# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :family do
    name {Faker::Name.last_name}
  end
end
