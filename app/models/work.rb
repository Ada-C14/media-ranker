class Work < ApplicationRecord
  validates :title, :creator, :description, presence: true
  validates :category, presence: true, inclusion: { in: %w(book movie album) }
  validates :published, presence: true, numericality: true

  has_many :votes

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
    media_list = categories(media).sort_by { |work| work.votes.count }.reverse

    if media_list.length >= 10
      return media_list.first(10)
    else
      return media_list
    end
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
    all.max_by { |work| work.votes.count }
  end



end
