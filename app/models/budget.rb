class Budget < ActiveRecord::Base
  has_many :costs

  def from_date
    DateFormatter.format(self.from)
  end

  def to_date
    DateFormatter.format(self.to)
  end

  def self.amount_for_range(from, to)
    time_period_id = TimePeriod.where(from: from, to: to).time_period_id
    budget = Budget.where(time_period_id: time_period_id).first
    budget.amount
  end

  def self.past
    budgets = Budget.where(current: false)
  end
end
