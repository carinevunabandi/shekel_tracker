class AddColumnCurrentBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :current, :boolean
  end
end
