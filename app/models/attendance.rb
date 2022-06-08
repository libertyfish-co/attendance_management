class Attendance < ApplicationRecord
  belongs_to :corporation
  belongs_to :employee
end
