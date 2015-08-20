class ShekelTracker < Sinatra::Base

  get '/view_current' do
    @current_budget = Budget.find_by(current: true)
    @total_costs    = Cost.total_for_period(@current_budget.time_period_id)
    @status         = StatusTeller.current(@current_budget.amount, @total_costs)
    @costs          = Cost.expenses_during(@current_budget.time_period_id)
    erb :'budget/current'
  end
end
