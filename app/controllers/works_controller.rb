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
    @work = Work.new
  end

  def create
    @work = Work.new(works_params)

    if @work.save
      flash[:success] = "Work added to the ranker"
      redirect_to work_path(@work) and return
    else
      flash[:error] = "Sorry, the work was not saved"
      render :new, status: :bad_request and return
    end
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
