# spec/factories/gardens.rb
require 'faker'

FactoryGirl.define do
  factory :leaf do |l|
    l.title { Faker::Lorem.word }
    l.body { Faker::Lorem.words(10) }
  end
end