class WorksController < ApplicationController
  def index
    @works = Work.all
    @movies = Work.sort_by_category("movie")
    @books = Work.sort_by_category("book")
    @albums = Work.sort_by_category("album")
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      flash[:warning] = "Invalid Media."
      redirect_to works_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:warning] = "Invalid request. Media not found."
      redirect_to works_path
      return
    end
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Media added successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "Oops! Something is wrong. Cannot add Media."
      redirect_to works_path
      return
    end

  end

  def update
    @work = Work.find_by(params[id])
    if @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "Oops! Something is wrong. Cannot add Media."
      render :edit
      return
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end

    if @work.destroy
      flash[:success] = "Media deleted."
      redirect_to works_path
      return
    else
      flash[:warning] = "Cannot delete Media."
      redirect_to works_path
    end
  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :description, :publication_year)
  end
end
