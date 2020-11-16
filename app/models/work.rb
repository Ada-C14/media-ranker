class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true

  def self.sort_votes
    works = Work.all
    sorted_work = works.sort_by{|work| work.votes.count}.reverse
    return sorted_work
  end

  def self.spotlight
    work = Work.all
    spotlight = work.sort_votes.first
    return spotlight
  end

  def self.top_ten_books
    work = Work.all
    books = []
    work.each do |work|
      if work.category == "book"
        books << work
      end
    end
    top_ten = books.sort_by{|work| work.votes.count}.reverse
    return top_ten[0...10]
  end

  def self.top_ten_albums
    work = Work.all
    albums = []
    work.each do |work|
      if work.category == "albums"
        albums << work
      end
    end
    top_ten = albums.sort_by{|work| work.votes.count}.reverse
    return top_ten[0...10]
  end

  def self.top_ten_movies
    work = Work.all
    movies = []
    work.each do |work|
      if work.category == "movies"
        movies << work
      end
    end
    top_ten = movies.sort_by{|work| work.votes.count}.reverse
    return top_ten[0...10]
  end


end
