FactoryGirl.define do
  factory :budget do
    spending_limit 100
    current true
    total_spending 70
    overspent false
    from '1-Jan-2010'
    to '31-Jan-2010'
  end

  trait :past_budget do
    current false
  end

  trait :with_10_costs do
    after(:create) do |budget|
      @categories = %w(Transport Bills Entertainment Food Donations).map do |cat_name|
        create(:category, name: cat_name)
      end

      (1..10).map do |number|
        number <= 5 ? index = number : index = number - 5
        create(:cost, price: number * 2, category_id: @categories[index - 1].id, budget: budget)
      end
    end
  end
end
