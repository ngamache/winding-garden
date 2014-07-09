# spec/factories/gardens.rb
require 'faker'

FactoryGirl.define do
  factory :garden_branch, class: Branch do |gb|
    gb.branching { create(:garden) }
    gb.name { Faker::Lorem.word }
    gb.description { Faker::Lorem.words(10) }
    gb.user { create(:user) }
  end
end

FactoryGirl.define do
  factory :leaf_branch, class: Branch do |lb|
    lb.branching { create(:leaf) }
    lb.name { Faker::Lorem.word }
    lb.description { Faker::Lorem.words(10) }
    lb.user { create(:user) }
  end
end