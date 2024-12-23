FactoryBot.define do
  factory :destination do
    name { "example" }
    address { "example_city" }
    latitude { 1.5 }
    longitude { 1.5 }
    is_private { false }
    association :user
    association :category
  end
end
