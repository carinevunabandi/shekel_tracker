class CreateTableBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :time_period_id
      t.integer :amount
    end
  end
end
