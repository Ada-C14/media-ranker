class HomepagesController < ApplicationController

  def index
    # @users = User.all
    # @works = Work.all
    # @votes = Vote.all

    @media_spotlight = Work.spotlight
    @top_movies = Work.top_ten(category: "movie")
    @top_books = Work.top_ten(category: "book")
    @top_albums = Work.top_ten(category: "album")
  end
end
