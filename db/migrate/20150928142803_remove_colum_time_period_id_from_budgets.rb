class RemoveColumTimePeriodIdFromBudgets < ActiveRecord::Migration
  def change
    remove_column :budgets, :time_period_id
  end
end
