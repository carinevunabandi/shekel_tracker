class AddBudgetToCost < ActiveRecord::Migration
  def change
    add_column :costs, :budget_id, :integer
  end
end
