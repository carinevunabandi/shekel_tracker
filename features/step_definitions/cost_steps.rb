Given 'there is an existing current budget' do
  @current_budget = create(:budget, :with_no_costs_yet)
end

And 'I am viewing that budget' do
  @current_budget_page = ViewBudgetPage.new
  @current_budget_page.load(id: @current_budget.id)
end

When 'I fill in the form to create a new cost' do
  @current_budget_page.date.set '1-Jan-2010'
  @current_budget_page.description.set 'some description'
  @current_budget_page.price.set '10'
  select 'Bills', from: 'categories_list'
end

When 'I click on add new cost' do
  @current_budget_page.add_cost_button.click
end

Then 'a new cost is created in the database' do
  expect(Cost.find_by(budget: @current_budget, description: 'some description')).to_not eq nil
end

And 'that cost is added to the list of existing costs for the current budget' do
  expect(@current_budget_page.shows_details_for_cost(Cost.find_by(description: 'some description'))).to eq true
end
