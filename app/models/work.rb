class Work < ApplicationRecord
  belongs_to :corporation
  has_many :attendance_details
end
