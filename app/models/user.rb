class User < ApplicationRecord
  validates :name, presence: :true
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :trackable

  include JpPrefecture
  jp_prefecture :prefecture_code
end
