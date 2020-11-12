class Work < ApplicationRecord

  def self.by_category(category)
    self.where(category: category).order(category: :desc) #TODO: change order to vote count when initialized
  end
end
