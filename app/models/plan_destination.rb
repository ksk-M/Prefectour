class PlanDestination < ApplicationRecord
  belongs_to :plan
  belongs_to :destination
end
