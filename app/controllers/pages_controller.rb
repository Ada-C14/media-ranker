class PagesController < ApplicationController
  def index
    @books = Work.books.limit(10)
    @albums = Work.books.limit(10)
    @movies = Work.books.limit(10)
    @spotlight = Work.spotlight
  end
end

    # @works = Work.all
    # @albums = Work.select{ |work| work.category == 'album'}
    # @books = Work.select{ |work| work.category == 'book'}
    # @movies = Work.select{ |work| work.category == 'movie'}
