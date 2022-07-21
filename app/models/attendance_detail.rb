class AttendanceDetail < ApplicationRecord
  require 'range'
  belongs_to :attendance
  belongs_to :order, optional: true
  belongs_to :work,optional: true

  def self.init_attendance_detail(attendance_id)
    result = []
    self.all.each do |attendance_detail|
      result.push(attendance_detail)
    end

    (10-self.all.length).times do |i|
      result.push(self.all.build(attendance_id: attendance_id))
    end
    return result
  end

  def self.join_work_contents
    result = ""
    self.all.each{|a|
      return "" if a.order_id.blank?
      result << a.order.name
    }
    result
  end

  # 保存時のエラー（整合性に問題があり、保存できない）をチェックする。
  # 引数：勤怠詳細レコードｓ
  # 返り値：配列（[[エラーコード、エラー内容],...]）
  def self.valid?(a_details)
    result = {}
    a_details = a_details.select{|a|!a.start_time.blank? || !a.end_time.blank?}
    if Range.overlap?(a_details.map{|a_d|a_d.start_time..a_d.end_time})
      result[:uniqe_err] = "E005008  時間が重複しています。重複しないように時刻を入力してください。".force_encoding("UTF-8")
    end

    a_details.each_with_index do |a_detail,i|
      if (i+1 < a_details.length) && (a_detail.end_time - a_details[i+1].start_time) != 0
        result[:continuous_time_err] = "E005007 連続していない時間があります。区間が連続するように時刻を入力してください。".force_encoding("UTF-8")
      end
      if a_detail.start_time > a_detail.end_time
        result[:start_bigger_err] = "E005009 開始時刻は終了時刻より前を入力してください。".force_encoding("UTF-8")
      end
      if (a_detail.start_time.blank? && a_detail.end_time.blank?)
        result[:times_lack_err] = "E005010 時刻をすべて入力してください。".force_encoding("UTF-8")
      end
    end
    result.to_a
  end

  # 勤怠詳細のワーニング（整合性は問題あるが保存できる）チェック
  # 引数：勤怠詳細レコードs
  # 返り値：配列（[[エラーコード、エラー内容],...]）
  def self.warning?(a_details)
    result = {}
    a_details = a_details.select{|a|!a.start_time.blank? || !a.end_time.blank?}

    a_details.each do |a_detail|
      if a_detail.order_id.nil?
        result[:order_nil_err] = "E005011 オーダーを入力してください。".force_encoding("UTF-8")
      end
      if a_detail.work_id.nil?
        result[:work_nil_err] = "E005012 作業を入力してください。".force_encoding("UTF-8")
      end
      if a_detail.work_content.to_s.length > 51
        result[:work_content_bigger_err] = "E005012 備考の入力文字数が上限(50文字)を超過しています。".force_encoding("UTF-8")
      end
    end
    result.to_a
  end
end
