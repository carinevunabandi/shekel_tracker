class ShekelTracker < Sinatra::Base

  get '/view_current' do
    @current_budget = Budget.find_by(current: true)
    if !@current_budget.nil?
      @total_costs    = Cost.total_for_period(@current_budget.time_period_id)
      @status         = StatusTeller.current(@current_budget.amount, @total_costs)
      @costs          = Cost.expenses_during(@current_budget.time_period_id)
      @totals_per_categories = Cost.totals_per_categories(@current_budget.time_period_id)
    end
    erb :'budget/current'
  end

  get '/budget/new' do
    erb :'budget/new'
  end

  post '/budget/new' do
    @time_period = TimePeriod.create(from: params['from'], to: params['to'])
    Budget.create(time_period_id: @time_period.id, amount: params['amount'], current: true)
    flash[:success] = "Budget created"
    redirect :'/view_current'
  end
end
