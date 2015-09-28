class RemoveTimePeriodFromCost < ActiveRecord::Migration
  def change
    remove_column :costs, :time_period_id
  end
end
