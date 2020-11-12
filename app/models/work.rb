class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes
  has_many :users, through: :votes

  def self.select_spotlight
    works = self.all
    spotlight = works.sort_by{|work| work.votes.length}.reverse[0]
    return spotlight
  end

  def self.select_top_ten(media)
    works = self.where(category: media[0..-2])
    top_works = works.sort_by{|work| work.votes.length}.reverse[0..9]
    return top_works
  end

end
