# spec/factories/gardens.rb
require 'faker'

FactoryGirl.define do
  factory :branch, class: Branch do |gb|
    gb.garden { create(:garden) }
    gb.name { Faker::Lorem.word }
    gb.description { Faker::Lorem.words(10) }
    gb.user { create(:user) }
  end
end
