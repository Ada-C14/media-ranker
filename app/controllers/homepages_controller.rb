class HomepagesController < ApplicationController

  def index
    # @users = User.all
    # @works = Work.all
    # @votes = Vote.all

    @media_spotlight = Work.spotlight
    @top_movies = Work.total_lists(category: "movie", limit: 10)
    @top_books = Work.total_lists(category: "book", limit: 10)
    @top_albums = Work.total_lists(category: "album", limit: 10)
  end
end
