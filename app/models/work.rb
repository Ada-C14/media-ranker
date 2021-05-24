class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: { message: "• title: can't be blank" }, uniqueness: { scope: :category, message: "• title: has already been taken" }

  def self.filter_category(category)
    Work.where(category: category)
  end

  def self.movies
    Work.filter_category(:movie)
  end

  def self.albums
    Work.filter_category(:album)
  end

  def self.books
    Work.filter_category(:book)
  end

  def self.top_ten(category)
    if self.nil?
      return nil
    else
      return self.filter_category(category).order(votes_count: :desc).first(10)
    end
  end

  def self.spotlight
    if self.nil?
      return nil
    else
      return self.order(votes_count: :desc).first
    end
  end

  def self.vote_date(vote)
    if self.nil?
      return nil
    else
      return (vote.created_at.strftime("%b %d, %Y"))
    end
  end
end
