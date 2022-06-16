class Attendance < ApplicationRecord
  belongs_to :corporation
  belongs_to :employee
  has_many :attendance_details
end
