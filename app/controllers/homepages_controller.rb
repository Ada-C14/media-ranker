class HomepagesController < ApplicationController

  skip_before_action :require_login

  def index

    @spotlight = Work.spotlight
    @books = Work.top_ten('book')
    @albums = Work.top_ten('album')
    @movies = Work.top_ten('movie')

  end

end