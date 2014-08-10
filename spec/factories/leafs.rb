# spec/factories/gardens.rb
require 'faker'

FactoryGirl.define do
  factory :leaf do |l|
    l.title { Faker::Lorem.word }
    l.body { Faker::Lorem.words(10) }
    l.user { create(:user) }
    l.garden { create(:garden) }
  end
end