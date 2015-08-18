Given "I am on the homepage" do
  visit "/"
end

When "I visit the homepage" do
  visit "/"
end

Then "I should see 'this month's budget' tab" do
  expect(page.body).to have_content("This Month's Budget")
end

Then "I should see 'View previous budgets' tab" do
  expect(page.body).to have_content("View Previous Budgets")
end
