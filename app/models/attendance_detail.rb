class AttendanceDetail < ApplicationRecord
  belongs_to :attendance
  belongs_to :order
  belongs_to :work
end
