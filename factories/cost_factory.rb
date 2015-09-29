FactoryGirl.define do
  factory :cost do
    price        10
    description  { Faker::Lorem.sentence }
    date         { Faker::Time.between('1-Jan-2010', '31-Jan-2010') }
    category_id  [1,2,3,4]
    budget_id    1
  end
end
