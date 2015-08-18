class Budget < ActiveRecord::Base
  belongs_to :time_period

  def self.amount_for_range(from, to)
    time_period_id = TimePeriod.where(from:from, to:to).time_period_id
    budget = Budget.where(time_period_id: time_period_id).first
    budget.amount
  end
end
