WORK_CATEGORIES = ["book", "album", "movie"]

class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true

  def self.by_category(category_string)
    return Work.where(category: category_string)
  end

  def self.spotlight
    works = self.all

    most_votes = works.max_by do |work|
      work.votes.count
    end

    return most_votes
  end

  def self.top_10
    works = self.all

    top_10 = works.max_by(10) do |work|
      work.votes.count
    end

    return top_10
  end

end
