class WorksController < ApplicationController
  def index
    @works = Work.all
    # @movies = Work.where(category: "movie")
    @album = Work.where(category: "album")
    @book = Work.where(category: "book")
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
