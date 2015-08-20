class Cost < ActiveRecord::Base
  belongs_to :category
  belongs_to :time_period

  def self.total_for_period(time_period_id)
    costs = Cost.where(time_period_id: time_period_id)
    prices = []
    if !costs.nil?
      prices = costs.map(&:price)
    end
    prices.reduce(:+)
  end

  def self.expenses_during(time_period_id)
    Cost.where(time_period_id: time_period_id).to_a
  end
end
