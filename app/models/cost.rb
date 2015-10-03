class Cost < ActiveRecord::Base
  belongs_to :category
  belongs_to :budget

  def formatted_date
    DateFormatter.format(date)
  end
end
