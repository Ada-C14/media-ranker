class PagesController < ApplicationController
  def index
    #@top_albums = Work.top_ten("album")
    #@top_books = Work.top_ten("book")
    #@top_movies = Work.top_ten("movie")
    @spotlight = Work.spotlight
  end
end

# def index
#   @works = Work.all
#   @albums = Work.select{ |work| work.category == 'album'}
#   @books = Work.select { |work| work.category == "book" }
#   @movies = Work.select{ |work| work.category == 'movie'}
# end

