class User < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy
  has_one_attached :icon

  validates :name, presence: :true, length: { maximum: 15 }
  validates :introduction, length: { maximum: 80 }

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :trackable

  include JpPrefecture
  jp_prefecture :prefecture_code
end
