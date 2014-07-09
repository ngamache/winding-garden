# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    username {Faker::Internet.user_name(firstname + ' ' + lastname) }
    email { Faker::Internet.email(firstname + ' ' + lastname) }
  end
end
