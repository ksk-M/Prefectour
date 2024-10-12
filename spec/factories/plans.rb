FactoryBot.define do
  factory :plan do
    title { "example" }
    start_date { "2024-10-02" }
    end_date { "2024-10-03" }
    association :group
  end
end
