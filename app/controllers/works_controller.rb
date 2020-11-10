class WorksController < ApplicationController

  def index
    @albums = Work.all.where(category: "album")
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    # if @work.nil?
    #   # here need to redirect to an error page
    # end

  end
end
