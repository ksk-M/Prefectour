class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :trackable

  include JpPrefecture
  jp_prefecture :prefecture_code
end
