require 'pry'

class Work < ApplicationRecord
  has_many :votes

  validates :creator, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category, message: "has already been taken"}

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
      return category_subset.max_by(10) { |x| x.votes.count}
    else
      return category_subset.max_by(category_subset.count / 2) { |x| x.votes.count}
    end
  end

  def self.category_desc_by_vote_count(media)
    category_subset = self.where(category: media)
    return category_subset.max_by(category_subset.length) { |work| work.votes.count }
  end
end
