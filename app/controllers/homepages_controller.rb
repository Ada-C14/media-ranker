class HomepagesController < ApplicationController

  def index
    @work = Work.all
    @work_first = @work.order('votes').first
    @albums = @work.where(category: "album").order('votes').first(10)
    @books = @work.where(category: "book").order('votes').first(10)
    @movies = @work.where(category: "movie").order('votes').first(10)
  end


end
