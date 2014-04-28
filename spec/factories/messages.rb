# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    content "MyText"
    conversation_id 1
    person_id 1
  end
end
