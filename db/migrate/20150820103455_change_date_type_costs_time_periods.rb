class ChangeDateTypeCostsTimePeriods < ActiveRecord::Migration
  def change
    change_column :costs, :date, :date
    change_column :time_periods, :from, :date
    change_column :time_periods, :to, :date
  end
end
