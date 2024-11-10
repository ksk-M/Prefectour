class User < ApplicationRecord
  has_many :group_users
  has_many :groups, through: :group_users, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_one_attached :icon

  validates :name, presence: :true, length: { maximum: 15 }
  validates :introduction, length: { maximum: 80 }

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :trackable

  include JpPrefecture
  jp_prefecture :prefecture_code

  def self.guest
    find_or_create_by(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.prefecture_code = 27
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
