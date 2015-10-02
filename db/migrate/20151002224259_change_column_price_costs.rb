class ChangeColumnPriceCosts < ActiveRecord::Migration
  def change
    change_column :costs, :price, :float
  end
end
