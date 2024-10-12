FactoryBot.define do
  factory :plan_destination do
    association :plan
    association :destination
  end
end
