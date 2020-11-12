class Work < ApplicationRecord
  has_many :users, through: :votes

  def self.select_spotlight
    @spotlight = Work.all.sample.title
    return @spotlight
  end

  def self.top_ten(category)
    @top_ten = Work.where(category).sample(10)
  end

  # def find_top_books
  #   return Work.where(category: 'book').sample(5)
  # end
  #
  # def find_top_ten_albums
  #   return Work.where(category: 'album').sample(5)
  # end
  #
  # def find_top_movies
  #   return Work.where(category: 'movies').sample(5)
  # end
end
