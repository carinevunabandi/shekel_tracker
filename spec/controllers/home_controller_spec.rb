describe 'GET /' do
  it 'shows the homepage heading' do
    get '/'
    expect(last_response.body).to match(/Home/)
    expect(last_response.body).to match(/Current Budget/)
    expect(last_response.body).to match(/Previous Budgets/)
  end
end
