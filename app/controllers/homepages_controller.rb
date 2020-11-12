class HomepagesController < ApplicationController

  def index
    @work = Work.all

    @work_first = @work.order('votes').first
    @albums = @work.find_by(category: "albums")
    @books = @work.find_by(category: "book")
    @movies = @work.find_by(category: "movie")
  end


end
