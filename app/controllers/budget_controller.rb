class ShekelTracker < Sinatra::Base

  get '/view_current' do
    @current_budget = Budget.find_by(current: true)
    @total_costs    = Cost.total_costs_for_period(@current_budget.time_period_id)
    erb :'budget/current'
  end
end
