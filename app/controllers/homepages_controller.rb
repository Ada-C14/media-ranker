class HomepagesController < ApplicationController
  def index
    @work = Work.spotlight
    @albums = Work.top_ten("album")
    @books = Work.top_ten("book")
    @movies = Work.top_ten("movie")
  end
end
