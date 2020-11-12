class Work < ApplicationRecord

  def self.select_spotlight
    spotlight = Work.all.sample.title
    return spotlight
  end

  def self.find_top_books
    return Work.where(category: 'book').sample(5)
  end

  def self.find_top_ten_albums
    return Work.where(category: 'album').sample(5)
  end

  def self.find_top_movies
    return Work.where(category: 'movies').sample(5)
  end
end
