When 'I view the homepage' do
  @homepage = Homepage.new
  @homepage.load
end

Given 'I am on the homepage' do
  visit '/'
end

Then "I see the 'current budget' tab" do
  expect(@homepage).to have_link('Current Budget')
end

Then "I see 'past budgets' tab" do
  expect(page.body).to have_link('Past Budgets')
end
