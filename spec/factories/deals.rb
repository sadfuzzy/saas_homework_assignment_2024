FactoryBot.define do
  factory :deal do
    company
    sequence(:name) { |n| "Deal #{n}" }
    amount { rand(10..1000) }
    status { %w(pending won lost).sample }
  end
end
