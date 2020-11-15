require 'pry'

class Work < ApplicationRecord
  has_many :votes

  validates :creator, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category, message: "has already been taken"}

  CATEGORIES = ["album", "movie", "book"]

  def self.spotlight
    if self.count == 0
      return nil
    elsif Vote.count == 0
      return self.all.sample
    else
      popular_stuff = []
      Work.all.each do |work|
        if work.votes.any?
          popular_stuff << work
        end
      end
      return popular_stuff.sample
    end
  end

  def self.top_ten(media)
    return nil if self.count == 0
    category_subset = self.where(category: media)
    if category_subset.count > 20
      return category_subset.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC, title')).first(10)
    else
      return category_subset.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC, title')).first(category_subset.length / 2)
    end
  end

  def self.category_desc_by_vote_count(media)
    return nil if self.count == 0
    category_subset = self.where(category: media)
    return category_subset.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC, title'))
  end
end
