# spec/factories/gardens.rb
require 'faker'

FactoryGirl.define do
  factory :branch do |b|
    b.garden { create(:garden) }
    b.name { Faker::Lorem.word }
    b.description { Faker::Lorem.words(10) }
  end
end