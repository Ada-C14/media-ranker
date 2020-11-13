class HomepagesController < ApplicationController

  def index
    @work = Work.all
    @work_first = @work.first
    #@work_first = @work.order('votes').first
    @albums = @work.where(category: "album")
    @books = @work.where(category: "book")
    @movies = @work.where(category: "movie")
  end


end
