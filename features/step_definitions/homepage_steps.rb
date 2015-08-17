When "I visit the homepage" do
  visit "/"
end

Then "I should see 'this month's budget' tab" do
  expect(page.body).to have_content("This month's budget")
end

Then "I should see 'View previous budgets' tab" do
  expect(page.body).to have_content("View previous budgets")
end
