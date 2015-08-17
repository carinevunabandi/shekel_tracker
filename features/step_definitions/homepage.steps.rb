When "I visit the homepage" do
  visit "/"
end

Then "I should see 'this month's budget' tab" do
  expect(page.body).to have_content("This month's bugdet")
end

Then "I should see 'View previous budgets' tab" do
  expect(page.body).to have_content("View previous bugdets")
end
