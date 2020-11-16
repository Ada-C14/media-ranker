# frozen_string_literal: true

class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category, message: "This title already exists in this category" } # Title cannot be duplicated for a single category
  validates :category, presence: true, inclusion: { in: %w(album book movie), message: "%{value} is not a valid category"}
  validates :publication_year, numericality: { only_integer: true, message: "Enter the year in mumaric value" }

  def self.albums
    Work.where(category: "album").sort_by_vote_count
  end

  def self.movies
    Work.where(category: "movie").sort_by_vote_count
  end

  def self.books
    Work.where(category: "book").sort_by_vote_count
  end

  def self.spotlight
    Work.all.max_by(10) { |work| work.votes.count }
  end

  def self.top_10(category)
    Work.all.where(category: category).max_by(10) { |work| work.votes.count }
  end

  def upvote

  end


end
