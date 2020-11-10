class WorksController < ApplicationController
  def index
    # @works = Work.all.order(:category)
    @albums = Work.all.where(category: "album")
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end
  end


  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "#{@work.name} was successfully added!"
      redirect_to work_path
      return
    else
      flash.now[:error] = "Something happened. #{@work.name} was not added."
      render :new, status: :bad_request
      return
    end
  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
