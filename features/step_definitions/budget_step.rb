And 'there are budgets in the database' do
  @budgets = [[1, '1-Jan-2010', '31-Jan-2010'],
              [2, '1-Feb-2010', '28-Feb-2010'],
              [3, '1-Mar-2010', '31-Mar-2010'],
              [4, '1-Apr-2010', '30-Apr-2010'],
              [5, '1-May-2010', '31-May-2010']].map do |number, from, to|
                create(:budget, :past_budget,
                       spending_limit: 700,
                       total_spending: number * 200,
                       overspent: overspent?(700, number),
                       from: from,
                       to: to)
              end
end

def overspent?(spending_limit, number)
  number * 200 > spending_limit ? true : false
end

When 'I view past budgets' do
  @homepage = Homepage.new
  @homepage.load
  @past_budgets_page = @homepage.view_past
end

Then 'I see the list of all past budgets' do
  @budgets.each do |budget|
    expect(@past_budgets_page).to have_row_for budget
  end
end

Given 'there is a current budget' do
  @budget = create(:budget)
end

And 'there are costs for the current budget' do
  @categories = %w(Transport Bills Entertainment Food Donations).map do |cat_name|
    create(:category, name: cat_name)
  end

  @costs = (1..10).map do |number|
    number <= 5 ? index = number : index = number - 5
    create(:cost, price: number * 2, category_id: @categories[index - 1].id, budget_id: @budget.id)
  end
end

When 'I view the current budget' do
  @homepage = Homepage.new
  @homepage.load
  @current_budget_page = @homepage.view_current
end

Then 'I see the spending limit for that budget' do
  expect(@current_budget_page).to have_spending_limit_for @budget
end

And "I see the current budget's time period" do
  expect(@current_budget_page).to have_time_period_for @budget
end

And 'I see the total amount spent so far' do
  expect(@current_budget_page).to have_total_spending_for @budget
end

And 'I see the status of my spending' do
  expect(@current_budget_page).to have_status_for @budget
end

And "I see the list of expenses during this budget's time" do
  expect(@current_budget_page).to have_list_of @costs
end

And 'I see the list of total spending per category' do
  expect(@current_budget_page).to have_list_of_categories_totals_for @costs
end

Given 'There is no current budget' do
  time_period_1 = TimePeriod.create(from: '1-May-2015', to: '31-May-2015')
  time_period_2 = TimePeriod.create(from: '1-Jul-2015', to: '30-Jul-2015')
  Budget.create(time_period_id: time_period_1.id, amount: 100, current: false)
  Budget.create(time_period_id: time_period_2.id, amount: 200, current: false)
  expect(Budget.where(current: true)).to eq []
end

# When "I click on this month's budget's link" do
# click_link('Current Budget')
# end

# Then 'I should see the monthly budget amount' do
# expect(page.body).to have_content('Budget Amount: 500')
# end

# And 'I should see the amount used so far' do
# expect(page.body).to have_content('Spent so far: 20')
# end

# And 'I should see the status of my current spending' do
# expect(page.body).to have_content('Status: Within budget')
# end

# And 'I should see the total spending per category' do
# expect(page.body).to have_content('Food: 2')
# expect(page.body).to have_content('Transportation: 8')
# expect(page.body).to have_content('Utility: 10')
# end

# And 'I should see the list of expenses during that period of time' do
# expect(page.body).to have_content('Water bill')
# expect(page.body).to have_content('15-Jun-1015')
# expect(page.body).to have_content('Monthly bus pass')
# expect(page.body).to have_content('3-Jun-1015')
# expect(page.body).to have_content('Taxi to Station')
# expect(page.body).to have_content('9-Jun-1015')
# expect(page.body).to have_content('Fish and Chips')
# end

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
