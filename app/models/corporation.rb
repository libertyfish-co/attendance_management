class Corporation < ApplicationRecord
    has_many :departments
    has_many :employees, through: :departments
    has_many :orders
    has_many :works
end
