class Attendance < ApplicationRecord
  belongs_to :employee
  has_many :attendance_details

  # Todo
  # 引数: なし
  # 返り値：オブジェクト配列
  # 例）オブジェクト配列
  # [{start_time,end_time,work_time,beak_time...},{start_time,end_time...}]

  # ～に勤怠データを加工する。
  # 月勤怠画面用のデータを加工する。
  # ※勤怠がない日にちも空文字入れて必ず、１～月末までデータをモデル側で作っておく。
  # ビュー楽になるからね
  def self.process_in_month
    # 1. 必要なデータ:開始時間、終了時間、作業,休憩,稼働,有給(一般),有給(特別),実働,控除、摘要（勤怠詳細オーダーIDの結合）
    # 2. 以上のデータを2次元マトリックスに加工する。
    # 例）
    # [{start_time:Tue, 28 Jun 2022 09:47:29 JST +09:00,end_time:Tue, 28 Jun 2022 18:47:29 JST +09:00...},
    # {start_time:'',end_time:''...}]
    # 何もない日は、空文字（''）を入れる
    # ※filter_byメソッドを使うこと。
    (self.first.base_date.beginning_of_month..self.first.base_date.end_of_month).each do |day|
      self.all.each do |attendance|
        #レコード内の必要なデータのみを抽出
        attendance_f = Attendance.filter_by(attendance)

        #開始時間データ加工
        if attendance_f.start_time.blank?
          start_time_proc = ''
        else
          start_time_proc = attendance_f.start_time.strftime("%R")
        end
        #終了時間データ加工
        if attendance_f.end_time.blank?
          end_time_proc = ''
        else
          end_time_proc = attendance_f.end_time.strftime("%R")
        end
        #作業時間データ加工
        #作業時間がない場合は空文字にする。作業＝稼働＋休憩だが、稼働がない場合は休憩があっても表示しない。
        if attendance_f.operating_time.blank?
          work_time_proc = ''
        else
          work_time_proc = sprintf("%10.2f", ((attendance.operating_time.to_i + attendance.break_time.to_i) / 60))
        end
        #休憩時間データ加工
        #休憩時間が存在しても稼働時間がなければ表示しない
        if attendance_f.break_time.blank? || attendance_f.operating_time.blank?
          break_time_proc = ''
        else
          break_time_proc = sprintf("%10.2f", (attendance_f.break_time / 60))
        end
        #稼働時間データ加工
        if attendance_f.operating_time.blank?
          operating_time_proc = ''
        else
          operating_time_proc = sprintf("%10.2f", (attendance_f.operating_time / 60))
        end
        #有給(一般)データ加工
        if attendance_f.paid_time.blank?
          paid_time_proc = ''
        else
          paid_time_proc = sprintf("%10.2f", (attendance_f.paid_time / 60))
        end
        #有給(特別)データ加工
        if attendance_f.special_paid_time.blank?
          special_paid_time_proc = ''
        else
          special_paid_time_proc = sprintf("%10.2f", (attendance_f.special_paid_time / 60))
        end
        #実働時間データ加工(実働時間 = 有給(一般) + 有給(特別) + 稼働時間)
        if paid_time_proc.blank? && special_paid_time_proc.blank? && operating_time_proc.blank?
          actual_work_time_proc = ''
        else
          actual_work_time_proc = sprintf("%10.2f", ((attendance_f.operating_time.to_i + attendance_f.paid_time.to_i + attendance_f.special_paid_time.to_i) / 60))
        end
        #控除データ加工
        if attendance_f.deduction_time.blank?
          deduction_time_proc = ''
        else
          deduction_time_proc = sprintf("%10.2f", (attendance.deduction_time / 60))
        end
        #摘要データ加工
        if attendance_f.work_content.blank?
          work_content_proc = ''
        else
          attendance.attendance_details.map {|detail| detail.order.name }
        end

        #勤怠登録情報のない日
        if attendance.base_date != day
          month_attendance_array[] = ['','','','','','','','','','']
        #勤怠登録情報のある日
        else
          month_attendance_array[] = 
          [start_time_proc,
          end_time_proc,
          working_time_proc,
          break_time_proc,
          operating_time_proc,
          paid_time_proc,
          special_paid_time_proc,
          actual_work_time_proc,
          work_content_proc]
        end
      end
    end
  end

  # Todo（7/1以降着手）
  # 週勤怠へ勤怠レコードｓを加工する。
  def self.process_in_week

  end



  # ************** private ******************
  # 2022/06/28 月勤怠フィルタは良好。（週勤怠未実装）
  # 引数：(string)month_attendance|week_attendance
  # 返り値：（フィルタされた）勤怠レコードｓ

  # 画面ごとに勤怠から必要なデータのみを選出する。
  def self.filter_by(page_name)
    self.select(nessarry_colmun_of(page_name))
  end

  # 引数：画面名
  # 返り値：シンボル配列
  def self.nessarry_colmun_of(page_name)
    {
      'month_attendance': [:start_time, :end_time, :break_time, :operating_time, 
        :paid_time, :special_paid_time, :deduction_time, :work_content],
      'week_attendance': []
    }[page_name]
  end

  private_class_method :filter_by, :nessarry_colmun_of

end
