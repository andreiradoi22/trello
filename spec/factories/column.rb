FactoryBot.define do
  factory :column do
    #sequence(:title) { |n| "title#{n}" }
    #sequence(:board_id) { |n| "board_id#{n}" }
    title { "title_col" }
    board_id { 2 }
  end
end