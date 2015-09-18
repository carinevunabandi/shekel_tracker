Given 'I am on the homepage' do
  visit '/'
end

When 'I visit the homepage' do
  visit '/'
end

Then "I should see the 'current budget' tab" do
  expect(page.body).to have_content('Current Budget')
end

Then "I should see 'previous budgets' tab" do
  expect(page.body).to have_content('Previous Budgets')
end
