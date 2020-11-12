class WorksController < ApplicationController

  def index
    @works = Work.all
    @movies = Work.where(category: 'movie')
    @books = Work.where(category: 'book')
    @albums = Work.where(category: 'album')
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
