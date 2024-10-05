class Plan < ApplicationRecord
  belongs_to :group
  has_many :plan_destinations
  has_many :destinations, through: :plan_destinations, dependent: :destroy

  validates :title, presence: true
end
