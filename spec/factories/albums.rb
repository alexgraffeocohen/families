# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :album do
    name {Faker::Name.name}
    family_id 2
    date "2014-04-08 11:11:22"
  end
end
