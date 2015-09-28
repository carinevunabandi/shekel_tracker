class DropTimePeriods < ActiveRecord::Migration
  def change
    drop_table :time_periods
  end
end
