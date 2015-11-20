class Cost < ActiveRecord::Base
  belongs_to :category
  belongs_to :budget

  validates :category_id, presence: true
  validates :description, presence: true
  validates :price,       presence: true,
                          numericality: { message: 'valid characters: 0-9' }
  validates :date,        presence: true

  before_save :check_date_within_budget_range

  def formatted_date
    DateFormatter.format(date)
  end

  def formatted_error_message
    error_message_lines = ''
    errors.full_messages.each do |error_message|
      error_message_lines << '- ' + error_message + '<br />'
    end
    error_message_lines
  end

  private

  def check_date_within_budget_range
    valid = budget.range.include?(date)
    errors.add(:date, 'date must be within budget range')
    valid
  end
end
