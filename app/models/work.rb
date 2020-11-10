class Work < ApplicationRecord

  def category
    @books = @works.where(category: "book")
    @albums = @works.where(category: "album")
    @movies = @works.where(category: "movie")
  end

  def top_10
    @top_books = @books.sample(10)
    @top_movies = @movies.sample(10)
    @top_albums = @books.sample(10)
  end

  def spotlight
    @spotlight = @works.sample(1)
  end

end
