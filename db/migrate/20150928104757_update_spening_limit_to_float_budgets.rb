class UpdateSpeningLimitToFloatBudgets < ActiveRecord::Migration
  def change
    change_column(:budgets, :spending_limit, :float)
  end
end
