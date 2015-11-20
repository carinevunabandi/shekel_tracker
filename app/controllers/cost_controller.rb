class ShekelTracker < Sinatra::Base
  post '/cost' do
    category = Category.find_by(name: params['cost']['category_id'])
    current_budget = Budget.find_by(current: true)
    @cost = Cost.new(date: params['cost_date'],
                     price: params['cost_price'],
                     description: params['cost_desc'],
                     category: category,
                     budget: current_budget)
    if @cost.save
      flash[:success] = 'Successfully created cost!'
    else
      flash[:error] = 'Unable to create cost: <br />' << @cost.formatted_error_message
    end
    redirect "/budget/#{current_budget.id}"
  end
end
