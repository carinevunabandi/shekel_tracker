class Budget < ActiveRecord::Base
  has_many :costs

  def from_date
    DateFormatter.format(from)
  end

  def to_date
    DateFormatter.format(to)
  end

  def self.past
    Budget.where(current: false)
  end

  def range
    (from..to).to_a
  end

  def self.current
    Budget.find_by(current: true)
  end
end
