class WorksController < ApplicationController

  def index
    @work = Work.all
    @albums = @work.find_by(category: "albums")
    @books = @work.find_by(category: "book")
    @movies = @work.find_by(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
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

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :votes)
  end

end
