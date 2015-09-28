class AddColumnsTotalSpendingOverspentToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :total_spending, :float
    add_column :budgets, :overspent, :boolean
  end
end
