class Attendance < ApplicationRecord
  belongs_to :employee
  has_many :attendance_details

  def self.get_attendances_at
    # Todo
    # 引数：（string） month|week|day
    # 返り値：勤怠レコードｓ

    # 月・週・日の勤怠をbase_dateから検索し、取得

  end

  def self.aggregate_time_of
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


  end

  def self.process_in_month
    # Todo
    # 引数: なし
    # 返り値：オブジェクト配列
    # 例）オブジェクト配列
    # [{start_time,end_time,work_time,beak_time...},{start_time,end_time...}]

    # ～に勤怠データを加工する。
    # 月勤怠画面用のデータを加工する。
    # ※勤怠がない日にちも空文字入れて必ず、１～月末までデータをモデル側で作っておく。
    # ビュー楽になるからね


  end

  def self.process_in_week
    # Todo（7/1以降着手）
    # 週勤怠へ勤怠レコードｓを加工する。

  end

  # ************** private ******************
  def self.filter_by
    # Todo
    # 引数：(string)month_attendance|week_attendance|day_attendance
    # 返り値：（フィルタされた）勤怠レコードｓ

    # 画面ごとに勤怠から必要なデータのみを選出する。

    
  end

  private_class_method :filter_by
end
