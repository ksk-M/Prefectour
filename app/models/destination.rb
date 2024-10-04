class Destination < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :plan_destinations
  has_many :plans, through: :plan_destinations

  validate :encourage_search_on_maps
  validates :name, length: { maximum: 20 }
  validates :address, length: { maximum: 60 }

  def encourage_search_on_maps
    if name.blank? || address.blank? || latitude.blank? || longitude.blank?
      if @new_record
        errors.add(:base, "Googleマップで場所を検索してください。一部項目が自動入力されます。（編集可）")
      else
        errors.add(:base, "場所の名前、住所は空欄にできません")
      end
    end
  end
end
