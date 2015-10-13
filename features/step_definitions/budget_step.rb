And 'there are budgets in the database' do
  @budgets = [[1, '1-Jan-2010', '31-Jan-2010'],
              [2, '1-Feb-2010', '28-Feb-2010'],
              [3, '1-Mar-2010', '31-Mar-2010'],
              [4, '1-Apr-2010', '30-Apr-2010'],
              [5, '1-May-2010', '31-May-2010']].map do |number, from, to|
                create(:budget, :past, :with_costs,
                       spending_limit: 700,
                       total_spending: number * 200,
                       overspent: (number * 200 > 700 ? true : false),
                       from: from,
                       to: to)
              end
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

Given 'there is a budget with associated costs' do
  @budget = create(:budget, :current_with_costs)
end

When 'I view that budget' do
  @view_budget_page = ViewBudgetPage.new
  @view_budget_page.load(id: @budget.id)
end

Then 'I see the spending limit for that budget' do
  expect(@view_budget_page).to have_spending_limit_for @budget
end

And 'I see the time period for that budget' do
  expect(@view_budget_page).to have_time_period_for @budget
end

And 'I see the total amount spent for that budget' do
  expect(@view_budget_page).to have_total_spending_for @budget
end

And 'I see the state of the spending rate for that budget' do
  expect(@view_budget_page).to have_status_for @budget
end

And "I see the list of expenses during that budget's time period" do
  expect(@view_budget_page).to have_list_of @budget.costs
end

And 'I see the list of total spending per category for that budget' do
  expect(@view_budget_page).to have_list_of_categories_totals_for @budget.costs
end

Given 'There is no current budget' do
  expect(Budget.where(current: true)).to eq []
end

When 'I want to create a new one' do
  @new_budget_page = NewBudgetPage.new
  @new_budget_page.load
end

And 'I enter details for the new budget and submit' do
  @new_budget_page.from_date_field.set '1-Aug-1010'
  @new_budget_page.to_date_field.set '31-Aug-1010'
  @new_budget_page.spending_limit_field.set '700'
  @new_budget_page.create_button.click
end

Then 'The new budget should be created' do
  expect(Budget.where(current: true).pluck(:spending_limit)).to eq [700]
end

And 'I should see a confirmation text and be redirected to viewing it' do
  expect(page.body).to have_content('Budget created')
  expect(current_path).to eq("/budget/#{Budget.find_by(current: true).id}")
end
