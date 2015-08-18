Given "there are costs for the current month" do
  time_period = TimePeriod.create(from:"1-June-2015", to:"30-June-2015")
  budget = Budget.create(time_period_id: time_period.id, amount: 500, current: true)
  category_1 = Category.create(name:"Transportation", description:"Anyting travel-related")
  category_2 = Category.create(name:"Utility",        description:"Any fixed/recurrent costs such as utility bills")
  category_3 = Category.create(name:"Food",           description:"Food")
  cost_1 = Cost.create(price:10, description:"Water bill",       category_id:category_2.id, time_period_id:time_period.id, date:"15-June-1015")
  cost_2 = Cost.create(price:5,  description:"Monthly bus pass", category_id:category_1.id, time_period_id:time_period.id, date:"3-June-1015")
  cost_3 = Cost.create(price:3,  description:"Taxi to Station",  category_id:category_1.id, time_period_id:time_period.id, date:"9-June-1015")
  cost_4 = Cost.create(price:2,  description:"Fish and Chips",   category_id:category_3.id, time_period_id:time_period.id, date:"9-June-1015")
end

When "I click on this month's budget's link" do
  click_link("This Month's Budget")
end

Then "I should see the monthly budget amount" do
  expect(page.body).to have_content("Budget Amount: 500")
end

And "I should see the amount used so far" do
  expect(page.body).to have_content("Spent so far: 20")
end

And "I should see the status of my current spending" do
  expect(page.body).to have_content("Status: Within budget")
end

And "I should see the total spending per category" do
  expect(page.body).to have_content("Food: 2")
  expect(page.body).to have_content("Transportation: 8")
  expect(page.body).to have_content("Utility: 10")
end

And "I should see the list of expenses during that period of time" do
  pending
end
