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
      flash[:error] = "Work not found"
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
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path and return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path and return
    elsif @work.update(works_params)
      flash[:success] = "Your work has been updated"
      redirect_to work_path(@work) and return
    else
      flash[:error] = "Sorry, your work was not updated"
      render :edit, status: :bad_request and return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work
      @work.destroy
      flash[:success] = "The work has been deleted"
      redirect_to works_path and return
    else
      flash[:error] = "The work could not be deleted"
      redirect_to works_path and return
    end
  end

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
