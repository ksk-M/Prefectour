class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users, dependent: :destroy
  has_many :plans, dependent: :destroy

  validates :name, presence: :true, length: { maximum: 15 }

  include JpPrefecture
  jp_prefecture :prefecture_code
end
