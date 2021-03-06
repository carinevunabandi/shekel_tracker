FactoryGirl.define do
  factory :budget do
    spending_limit 100
    current true
    total_spending 70
    overspent false
    from '1-Jan-2010'
    to '31-Jan-2010'
  end

  trait :past do
    current false
  end
  # :nocov:
  trait :current_with_costs do
    after(:create) do |budget|
      categories = create_categories
      (1..rand(10...20)).each do |number|
        create(:cost, price: number * 0.2, category_id: categories[rand(0...5)].id, budget: budget)
      end
    end
  end

  trait :with_costs do
    after(:create) do |budget|
      categories = create_categories
      (1..rand(10...50)).each do |num|
        create(:cost, price: num * 0.2, category_id: categories[rand(0...5)].id, budget: budget, date: Faker::Date.between(budget.from, budget.to))
      end
    end
  end
end

def create_categories
  %w(Transport Bills Entertainment Food Donations).map { |cat_name| create(:category, name: cat_name) }
end
# :nocov:
