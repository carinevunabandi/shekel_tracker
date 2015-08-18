class ChangeColumnTypeTimePeriodIdCosts < ActiveRecord::Migration
  def change
    change_column :costs, :time_period_id, :integer
  end
end
