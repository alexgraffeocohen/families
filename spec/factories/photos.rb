# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    image_url "MyString"
    album_id 1
  end
end
