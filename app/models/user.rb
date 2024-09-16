class User < ApplicationRecord
  has_many :group_users
  has_many :groups, through: :group_users
  has_one_attached :icon

  validates :name, presence: :true
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :trackable

  include JpPrefecture
  jp_prefecture :prefecture_code
end
