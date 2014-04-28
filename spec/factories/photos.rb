# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    album_id 1
    caption {Faker::Lorem.sentence}
  end
end
