class Destination < ApplicationRecord
  belongs_to :user

  validate :encourage_search_on_maps
  validates :name, length: { maximum: 20 }
  validates :address, length: { maximum: 60 }

  def encourage_search_on_maps
    if name.blank? || address.blank? || latitude.blank? || longitude.blank?
      if @new_record
        errors.add(:base, "地図で場所を検索してください")
      else
        errors.add(:base, "場所の名前、住所は空欄にできません")
      end
    end
  end
end