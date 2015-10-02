require 'factory_girl'
require 'faker'

FactoryGirl.find_definitions

def overspent?(spending_limit, number)
  number*200 > spending_limit ? true : false
end

Budget.destroy_all
[[1, "1-Jan-2010", "31-Jan-2010"],
 [2, "1-Feb-2010", "28-Feb-2010"],
 [3, "1-Mar-2010", "31-Mar-2010"],
 [4, "1-Apr-2010", "30-Apr-2010"],
 [5, "1-May-2010", "31-May-2010"]].each do |number, from, to|
   FactoryGirl.create(:budget, :past_budget,
          spending_limit: 700,
          total_spending: number*200,
          overspent: overspent?(700, number),
          from: from,
          to: to)
 end

FactoryGirl.create(:budget)

Category.destroy_all
@categories = ["Transport", "Bills", "Entertainment", "Food", "Donations"].map do |cat_name|
  FactoryGirl.create(:category, name: cat_name)
end

Cost.destroy_all
(1..10).each do |number|
  number <= 5 ? index = number : index = number - 5
  FactoryGirl.create(:cost, price: number*0.2, category_id: @categories[index-1].id , budget_id: Budget.find_by(current: true).id)
end
