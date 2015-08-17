describe 'GET /' do
  it 'shows the homepage heading' do
    get '/'
    expect(last_response.body). to match(/keeping track of your bucks/)
    expect(last_response.body). to match(/This month's budget/)
    expect(last_response.body). to match(/View previous budgets/)
  end
end
