class RenameAmountColumnBudgets < ActiveRecord::Migration
  def change
    rename_column :budgets, :amount, :spending_limit
  end
end
