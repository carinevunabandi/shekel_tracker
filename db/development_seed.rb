require 'factory_girl'
require 'faker'

FactoryGirl.find_definitions

Budget.destroy_all
Category.destroy_all
Cost.destroy_all

%w(Transport Bills Entertainment Food Donations).map { |cat_name| FactoryGirl.create(:category, name: cat_name) }

FactoryGirl.create(:budget, :current_with_costs)


[[1, "1-Jan-2010", "31-Jan-2010"],
 [2, "1-Feb-2010", "28-Feb-2010"],
 [3, "1-Mar-2010", "31-Mar-2010"],
 [4, "1-Apr-2010", "30-Apr-2010"],
 [5, "1-May-2010", "31-May-2010"]].each do |number, from, to|
   FactoryGirl.create(:budget, :past, :with_costs,
                      spending_limit: 700,
                      total_spending: number*200,
                      overspent: (number*200 > 700 ? true : false ),
                      from: from,
                      to: to)
 end
