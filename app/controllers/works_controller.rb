class WorksController < ApplicationController
  def index
    @works = Work.all

    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash.now[:error] = "Work not found"
      redirect_to works_path and return
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

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
