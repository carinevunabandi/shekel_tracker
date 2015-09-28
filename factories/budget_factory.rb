FactoryGirl.define do
  factory :budget do
    spending_limit  100
    current         true
    total_spending  50
    overspent       false
    from            "1-Jan-2010"
    to              "31-Jan-2010"
  end

  trait :previous_budget do
    current   false
  end
end
