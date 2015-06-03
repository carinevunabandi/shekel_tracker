class CreateTimePeriodsTable < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|
      t.datetime :from, null: false
      t.datetime :to, null: false
    end
  end
end
