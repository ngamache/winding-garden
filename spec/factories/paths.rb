# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :path do |p|
    p.garden { create(:garden) }
    p.user { create(:user) }
  end
end
