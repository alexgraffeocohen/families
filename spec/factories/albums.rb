# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :album do
    name {Faker::Name.name}
    family_id 2
    permissions "1 2"
    person_id 1
  end
end
