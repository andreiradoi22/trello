FactoryBot.define do
  factory :story do
    title { "title_story" }
    description { "description story" }
    status { "TO DO" }
    due_date { "2022-12-12" }
    column_id { 2 }
  end 
end