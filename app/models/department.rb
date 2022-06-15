class Department < ApplicationRecord
    belongs_to :corporation
    has_many :employees
end
