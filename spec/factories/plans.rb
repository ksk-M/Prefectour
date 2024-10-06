FactoryBot.define do
  factory :plan do
    title { "MyString" }
    note { "MyText" }
    start_date { "2024-10-02" }
    end_date { "2024-10-02" }
    group { nil }
  end
end
