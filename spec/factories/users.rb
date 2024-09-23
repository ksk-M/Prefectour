FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "example#{n}@example" }
    password { "000000" }
    password_confirmation { "000000" }

    after(:create) do |user|
      create_list(:group_user, 1, user: user, group: create(:group))
    end
  end
end
