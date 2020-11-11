class Work < ApplicationRecord
  validates :title, :creator, :description, presence: true
  validates :category, presence: true, inclusion: { in: %w(book movie album) }
  validates :published, presence: true, numericality: true


  # @works = Work.all

    # @books = Work.all.where(category: "book")
    # @movies = Work.all.where(category: "movie")
    # @albums = Work.all.where(category: "album")
    #
    # @top_books = Work.all.where(category: "book").sample(10)
    # @top_movies = Work.all.where(category: "movie").sample(10)
    # @top_albums = Work.all.where(category: "album").sample(10)



  # @spotlight = @works.sample(1)

end
