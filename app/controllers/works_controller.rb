class WorksController < ApplicationController
  def index
    @albums = Work.all_albums
    @books = Work.all_books
    @movies = Work.all_movies
  end

  def show
    @work = Work.find_by(id: params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    elsif @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      redirect_to works_path
      return
    end
  end

  def main
    @works = Work.all
    @albums = Work.top_albums
    @books = Work.top_books
    @movies = Work.top_movies
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
