FactoryBot.define do
  sequence(:email) { |n| "teacher#{n}@example.com" }

  factory :teacher do
    email { generate(:email) }
    password { "password123" }
    password_confirmation { "password123" }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
