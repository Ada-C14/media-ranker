# frozen_string_literal: true

class Work < ApplicationRecord

  return params.require(:work).permit(:title, :description, :creator, :publication_date, :category)


  has_many :votes
  has_many :users # UNSURE about this


  validates :title, presence: true

  def self.albums
    Work.where(category: "album")
  end

  def self.movies
    Work.where(category: "movie")
  end

  def self.books
    Work.where(category: "book")
  end

  def self.spotlight
    Work.first
  end

  def self.top_10(category)
    Work.where(category: category).sample(10)
  end
end
