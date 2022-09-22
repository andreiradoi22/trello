FactoryBot.define do
  factory :board do
    #sequence(:title) { |n| "title#{n}" }
    #sequence(:body) { |n| "body#{n}" }
    title { "title" }
    body { "body" }
  end
end