class Cost < ActiveRecord::Base
  belongs_to :category
  belongs_to :time_period
end
