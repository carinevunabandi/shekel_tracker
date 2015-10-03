class Cost < ActiveRecord::Base
  belongs_to :category
  belongs_to :budget

  def formatted_date
    DateFormatter.format(date)
  end

  def self.total_for_period(time_period_id)
    costs = Cost.where(time_period_id: time_period_id).to_a
    if costs != []
      prices = costs.map(&:price)
      prices.reduce(:+)
    else
      0
    end
  end

  def self.expenses_during(time_period_id)
    Cost.where(time_period_id: time_period_id).to_a
  end

  def self.totals_per_categories(time_period_id)
    costs = Cost.where(time_period_id: time_period_id)
    return nil if costs.nil?
    single_cats_and_prices = costs.joins('LEFT OUTER JOIN categories ON categories.id = costs.category_id').pluck(:name, :price)
    bundled_cats_and_prices = single_cats_and_prices.group_by(&:first).map { |key, array| [key, array.map(&:last)] }
    hashed_bundled_cats_and_prices = Hash[bundled_cats_and_prices]
    Cost.aggregate_category_costs(hashed_bundled_cats_and_prices)
  end

  def self.aggregate_category_costs(expenses_per_category)
    expenses_per_category.each { |key, value| expenses_per_category[key] = value.reduce(:+) }
  end
end
