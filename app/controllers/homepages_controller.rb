class HomepagesController < ApplicationController
  def index
    # @works = Work.all
    @albums = Work.top_10("album")
    @movies = Work.top_10("movie")
    @books = Work.top_10("book")

    @spotlight = Work.spotlight
  end
end
