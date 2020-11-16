class HomepagesController < ApplicationController
  def index
    @top_books = Work.top_10("book")
    @top_albums = Work.top_10('album')
    @top_movies = Work.top_10('movie')
    @spotlight = Work.spotlight
  end
end
