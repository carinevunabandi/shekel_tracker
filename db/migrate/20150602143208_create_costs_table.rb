class CreateCostsTable < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.integer  :price
      t.text     :description
      t.string   :category_id
      t.datetime :time_period_id
    end
  end
end
