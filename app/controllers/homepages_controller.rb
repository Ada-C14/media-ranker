class HomepagesController < ApplicationController

  skip_before_action :require_login

  def index

    # @works = Work.all
    #
    # @albums = Work.top_ten("album")
    #
    # @books = Work.top_ten("book")
    #
    # @movies = Work.top_ten("movie")

    @spotlights = Work.spotlight

  end
end