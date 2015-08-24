Given "there are costs for the current month" do
  time_period = TimePeriod.create(from:"1-June-2015", to:"30-June-2015")
  Budget.create(time_period_id: time_period.id, amount: 500, current: true)
  category_1 = Category.create(name:"Transportation", description:"Anyting travel-related")
  category_2 = Category.create(name:"Utility",        description:"Any fixed/recurrent costs such as utility bills")
  category_3 = Category.create(name:"Food",           description:"Food")
  Cost.create(price:10, description:"Water bill",       category_id:category_2.id, time_period_id:time_period.id, date:"15-Jun-1015")
  Cost.create(price:5,  description:"Monthly bus pass", category_id:category_1.id, time_period_id:time_period.id, date:"3-Jun-1015")
  Cost.create(price:3,  description:"Taxi to Station",  category_id:category_1.id, time_period_id:time_period.id, date:"9-Jun-1015")
  Cost.create(price:2,  description:"Fish and Chips",   category_id:category_3.id, time_period_id:time_period.id, date:"9-Jun-1015")
end

Given "There is no current budget" do
  time_period_1 = TimePeriod.create(from:"1-May-2015", to:"31-May-2015")
  time_period_2 = TimePeriod.create(from:"1-Jul-2015", to:"30-Jul-2015")
  Budget.create(time_period_id: time_period_1.id, amount: 100, current: false)
  Budget.create(time_period_id: time_period_2.id, amount: 200, current: false)
  expect(Budget.where(current: true)).to eq []
end

When "I click on this month's budget's link" do
  click_link("Current Budget")
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
  expect(page.body).to have_content("Water bill")
  expect(page.body).to have_content("15-Jun-1015")
  expect(page.body).to have_content("Monthly bus pass")
  expect(page.body).to have_content("3-Jun-1015")
  expect(page.body).to have_content("Taxi to Station")
  expect(page.body).to have_content("9-Jun-1015")
  expect(page.body).to have_content("Fish and Chips")
end

When "I want to create a new one" do
  visit '/budget/new'
end

And "I enter details for the new budget" do
  fill_in('from',    with: '1-Aug-2015')
  fill_in('to',      with: '31-Aug-2015')
  fill_in('amount', with: '700')
end

Then "The new budget should be created" do
  expect(TimePeriod.where(from: '1-08-2015', to: '31-08-2015')).not_to eq []
  expect(Budget.where(current: true).pluck(:amount)).to eq [700]
end

And "I should see a confirmation page for it" do
  pending
end
