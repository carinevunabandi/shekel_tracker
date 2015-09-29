FactoryGirl.define do
  factory :category do
    name        { Faker::Lorem::Word }
    description { Faker::Lorem.sentence }
  end
end
