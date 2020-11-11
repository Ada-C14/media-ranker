class WorksController < ApplicationController

  def index
    @works_book = Work.where(category: 'book')
    @works_album = Work.where(category: 'album')
    @works_movie = Work.where(category: 'movie')
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end



end
