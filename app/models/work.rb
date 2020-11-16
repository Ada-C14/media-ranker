require 'pry'

class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

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

    specific_category = self.where(category: media)

    if specific_category.count > 20
      return specific_category.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC, title')).first(10)
    else
      return specific_category.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC, title')).first(specific_category.length / 2)
    end
  end

  def self.category_desc_by_vote_count(media)
    return nil if self.count == 0
    specific_category = self.where(category: media)
    return specific_category.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC, title'))
  end
end
