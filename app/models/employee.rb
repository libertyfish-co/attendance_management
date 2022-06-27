class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :department
  delegate :corporation, to: :department
  has_many :attendances

  # 物理削除の代わりにユーザーの`deleted_at`をタイムスタンプで更新
  def soft_delete  
    update_attribute(:invalid_flag, true)  
  end

  # ユーザーのアカウントが有効であることを確認 
  def active_for_authentication?  
    super && invalid_flag  
  end  

  # 削除したユーザーにカスタムメッセージを追加します  
  def inactive_message   
    invalid_flag ? super : :deleted_account  
  end 
end
