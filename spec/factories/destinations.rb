FactoryBot.define do
  factory :destination do
    name { "MyString" }
    note { "MyText" }
    latitude { 1.5 }
    longitude { 1.5 }
    user { nil }
    is_private { false }
  end
end
