FactoryBot.define do
  factory :teacher do
    email { "teacher@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
