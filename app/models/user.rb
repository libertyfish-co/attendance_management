class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:timeoutable
         
  validates :emp_num,presence: true, uniqueness: true
  validates :password,presence: true, format: {with: /\A[a-zA-Z0-9]+\z/}
end
