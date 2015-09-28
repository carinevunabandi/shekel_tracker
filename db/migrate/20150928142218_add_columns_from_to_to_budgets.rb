class AddColumnsFromToToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :from, :date
    add_column :budgets, :to,   :date
  end
end
