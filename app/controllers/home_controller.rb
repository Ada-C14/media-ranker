class HomeController < ApplicationController

  def index
    @works = Work.all
    @spotlight = Work.spotlight_selection
    @top_books = Work.top_10_works_in_category("book")
    @top_movies = Work.top_10_works_in_category("movie")
    @top_albums = Work.top_10_works_in_category("album")
  end
  # filters/maps

  # albums = @works.select {|row| row.category == album}
  # return albums
end
