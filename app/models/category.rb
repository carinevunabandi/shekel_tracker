class Category < ActiveRecord::Base
  has_many :costs

  def self.all_names
    Category.all.map(&:name)
  end
end
