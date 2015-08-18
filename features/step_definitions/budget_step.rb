When "I click on this month's budget's link" do
  click_link("This month's budget")
end

Then "I should see the monthly budget amount" do
  expect(page.body).to have_content("Budget Amount")
end

And "I should see the amount used so far" do
  pending
end

And "I should see the status of my current spending" do
  pending
end

And "I should see the total spending per category" do
  pending
end
