describe 'GET /' do
  it 'shows the homepage heading' do
    get '/'
    expect(last_response.body).to match(/Keeping count of your bucks/)
    expect(last_response.body).to match(/This Month's Budget/)
    expect(last_response.body).to match(/View Previous Budgets/)
  end
end
