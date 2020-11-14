require 'pry'

class Work < ApplicationRecord
  validates :creator, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category, message: "has already been taken"}

  def self.spotlight
    return self.all.sample
  end

  def votes
    return rand(1..10)
  end

  def self.top_ten(media)
    return nil if self.count == 0
    category_subset = self.where(category: media)
    if category_subset.count > 20
      return category_subset.max_by(10) { |x| x.votes.count}
    else
      return category_subset.max_by(category_subset.count / 2) { |x| x.votes.count}
    end
  end

end
