class AttendanceDetail < ApplicationRecord
  belongs_to :attendance
  belongs_to :order
  belongs_to :work

  def self.init_attendance_detail(attendance_id)
    result = []
    p self.class
    self.all.each do |attendance_detail|
      result.push(attendance_detail)
    end

    (10-self.all.length).times do |i|
      result.push(self.all.build(attendance_id: attendance_id))
    end
    return result
  end
end
