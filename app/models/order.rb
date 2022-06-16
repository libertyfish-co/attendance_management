class Order < ApplicationRecord
  belongs_to :corporation
  has_many :attendance_details
end
