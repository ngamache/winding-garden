# spec/factories/gardens.rb
require 'faker'

FactoryGirl.define do
  factory :garden do |g|
    g.name { Faker::Lorem.word }
    g.description { Faker::Lorem.words(10) }
  end
end