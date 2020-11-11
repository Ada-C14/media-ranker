class Work < ApplicationRecord
  validates :title, :creator, :description, presence: true
  validates :category, presence: true, inclusion: { in: %w(book movie album) }
  validates :published, presence: true, numericality: true

  def self.categories(media)
    where(category: media)
  end

  def self.movies
    categories(:movie)
  end

  def self.books
    categories(:book)
  end

  def self.albums
    categories(:album)
  end


  def self.top_10(media)
     where(category: media).sample(10)
  end

  def self.top_books
    top_10(:book)
  end

  def self.top_movies
    top_10(:movie)
  end

  def self.top_albums
    top_10(:album)
  end

  def self.spotlight
    all.sample(1)[0]
  end

end
