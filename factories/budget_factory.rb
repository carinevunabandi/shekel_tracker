FactoryGirl.define do
  factory :budget do
    spending_limit  100
    current         true
    total_spending  70
    overspent       false
    from            "1-Jan-2010"
    to              "31-Jan-2010"
  end

  trait :past_budget do
    current   false
  end
end
