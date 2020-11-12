class WorksController < ApplicationController
  def index
    @books = Work.where(category: 'book').sample(10)
    @movies = Work.where(category: 'movie').sample(10)
    @albums = Work.where(category: 'album').sample(10)
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    else
      @users = @work.users
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
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
