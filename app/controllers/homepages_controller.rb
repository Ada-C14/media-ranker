class HomepagesController < ApplicationController
  def index
    @movies = Work.top_ten("movie")
    @books = Work.top_ten("book")
    @albums = Work.top_ten("album")
    @spotlight = Work.spotlight
  end
end

