class AttendanceDetail < ApplicationRecord
  belongs_to :attendance
  belongs_to :order
  belongs_to :work

  def self.init_attendance_detail
    result = []
    10.times do |i|
      result.push(self.new(start_time:nil,end_time:nil,order_id:nil,work_id:nil,work_content:nil))
    end
    return result
  end
end
