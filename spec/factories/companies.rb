FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Company #{n}" }
    employee_count { rand(1..999) }
    industry { Faker::Company.industry }
  end
end
