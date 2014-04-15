# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "Picnic in the Park"
    content "An awesome family reunion!"
    start_date "2014-04-14 10:06:56"
    end_date "2014-04-15 10:06:56"
  end
end
