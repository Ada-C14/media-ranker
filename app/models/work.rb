class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  def self.albums
    return albums = Work.where(category: "album")
  end

  def self.books
    return books = Work.where(category: "book")
  end

  def self.movies
    return movies = Work.where(category: "movie")
  end
