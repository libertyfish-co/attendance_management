class Attendance < ApplicationRecord
  belongs_to :employee
  has_many :attendance_details

  # Todo
  # 引数：（string） month|week|day
  # 返り値：勤怠レコードｓ

  # 月・週・日の勤怠をbase_dateから検索し、取得
  def self.get_attendances_at

  end

  # Todo
  # 引数：なし
  # 返り値：
  # total: 
  #   {work_time,break_time,operating,
  #     paid_time,special_paid_time,
  #     actual_time,deducation_time}

  # 作業,休憩,稼働,有給(一般),有給(特別),実働,控除
  # を持ったオブジェクトを返す。
  # Selfから勤怠レコードｓの合計時間を集計する。
  def self.aggregate_time_of


  end

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
