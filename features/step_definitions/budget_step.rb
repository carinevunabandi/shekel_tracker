And "there are budgets in the database" do
  @budgets = [[1, "1-Jan-2010", "31-Jan-2010"],
              [2, "1-Feb-2010", "29-Feb-2010"],
              [3, "1-Mar-2010", "31-Mar-2010"],
              [4, "1-Apr-2010", "30-Apr-2010"],
              [5, "1-May-2010", "31-May-2010"]].each do |number, from, to|
                create(:budget, :previous_budget,
                       spending_limit: 700,
                       total_spending: number*200,
                       overspent: overspent?(700, number),
                       from: from,
                       to: to)
              end
end

def overspent?(spending_limit, number)
  number*200 > spending_limit ? true : false
end

When "I view past budgets" do
  @homepage = Homepage.new
  @homepage.load
  @past_budgets_page = @homepage.view_past
end

Then "I see the list of all past budgets" do
  @budgets.each do |budget|
    expect(@previous_budgets_page).to have_row_for(budget)
  end
end

Given 'there are costs for the current month' do
  time_period = TimePeriod.create(from: '1-June-2015', to: '30-June-2015')
  Budget.create(time_period_id: time_period.id, amount: 500, current: true)
  category_1 = Category.create(name: 'Transportation', description: 'Anyting travel-related')
  category_2 = Category.create(name: 'Utility',        description: 'Any fixed/recurrent costs such as utility bills')
  category_3 = Category.create(name: 'Food',           description: 'Food')
  Cost.create(price: 10, description: 'Water bill',       category_id: category_2.id, time_period_id: time_period.id, date: '15-Jun-1015')
  Cost.create(price: 5,  description: 'Monthly bus pass', category_id: category_1.id, time_period_id: time_period.id, date: '3-Jun-1015')
  Cost.create(price: 3,  description: 'Taxi to Station',  category_id: category_1.id, time_period_id: time_period.id, date: '9-Jun-1015')
  Cost.create(price: 2,  description: 'Fish and Chips',   category_id: category_3.id, time_period_id: time_period.id, date: '9-Jun-1015')
end

Given 'There is no current budget' do
  time_period_1 = TimePeriod.create(from: '1-May-2015', to: '31-May-2015')
  time_period_2 = TimePeriod.create(from: '1-Jul-2015', to: '30-Jul-2015')
  Budget.create(time_period_id: time_period_1.id, amount: 100, current: false)
  Budget.create(time_period_id: time_period_2.id, amount: 200, current: false)
  expect(Budget.where(current: true)).to eq []
end

When "I click on this month's budget's link" do
  click_link('Current Budget')
end

Then 'I should see the monthly budget amount' do
  expect(page.body).to have_content('Budget Amount: 500')
end

And 'I should see the amount used so far' do
  expect(page.body).to have_content('Spent so far: 20')
end

And 'I should see the status of my current spending' do
  expect(page.body).to have_content('Status: Within budget')
end

And 'I should see the total spending per category' do
  expect(page.body).to have_content('Food: 2')
  expect(page.body).to have_content('Transportation: 8')
  expect(page.body).to have_content('Utility: 10')
end

And 'I should see the list of expenses during that period of time' do
  expect(page.body).to have_content('Water bill')
  expect(page.body).to have_content('15-Jun-1015')
  expect(page.body).to have_content('Monthly bus pass')
  expect(page.body).to have_content('3-Jun-1015')
  expect(page.body).to have_content('Taxi to Station')
  expect(page.body).to have_content('9-Jun-1015')
  expect(page.body).to have_content('Fish and Chips')
end

When 'I want to create a new one' do
  visit '/budget/new'
end

And 'I enter details for the new budget and submit' do
  fill_in('from',    with: '1-Aug-2015')
  fill_in('to',      with: '31-Aug-2015')
  fill_in('amount', with: '700')
  click_button('Create budget')
end

Then 'The new budget should be created' do
  expect(TimePeriod.where(from: '2015-08-01', to: '2015-08-31')).not_to eq []
  expect(Budget.where(current: true).pluck(:amount)).to eq [700]
end

And 'I should see a confirmation text and be redirected to viewing it' do
  expect(page.body).to have_content('Budget created')
  expect(current_path).to eq('/view_current')
end
