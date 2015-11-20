require 'spec_helper'

describe 'POST /' do
  let(:current_budget)   { create(:budget) }
  let(:category)         { create(:category, name: 'Donations') }
  let(:valid_cost)       { build(:cost, description: 'A description', price: '40', date: '01-Jan-2010', budget: current_budget, category: category) }
  let(:params) do
    {
      'cost_date' => '01-Jan-2010',
      'cost_desc' => 'A description',
      'cost_price' => '40',
      'cost' => { 'category_id' => 'Donations' }
    }
  end

  before do
    allow(Category).to receive(:find_by).with(name: params['cost']['category_id']).and_return(category)
    allow(Budget).to receive(:find_by).with(current: true).and_return(current_budget)
  end

  it 'instantiates a new cost' do
    allow(Cost).to receive(:new).and_return(valid_cost)
    expect(Cost).to receive(:new).with(price: params['cost_price'],
                                       description: params['cost_desc'],
                                       category: category,
                                       date: params['cost_date'],
                                       budget: current_budget)
    post '/cost', params
  end

  context 'Successful creation of cost' do
    it 'displays a flash success message on creation' do
      post '/cost', params
      follow_redirect!
      expect(last_response.body).to match(/Successfully created cost/)
    end
  end

  context 'Unsuccessful creation' do
    it 'displays a flash error message on failed creation' do
      invalid_params = { 'cost_date' => nil, 'cost_desc' => nil, 'cost_price' => 10, 'cost' => { 'category_id' => 'Donations' } }
      post '/cost', invalid_params
      follow_redirect!
      expect(last_response.body).to match(/Unable to create cost/)
    end
  end
end
