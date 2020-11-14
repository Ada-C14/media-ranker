class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  def index
    @albums = Work.where(category: "album").sort_by_vote_count
    @books = Work.where(category: "book").sort_by_vote_count
    @movies = Work.where(category: "movie").sort_by_vote_count
  end

  def show
    if @work.nil?
      flash[:warning] = "Work not found"
      redirect_to root_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "#{@work.category.capitalize} added successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: could not create #{@work.category}."
      render :new, status: :bad_request
      return
    end
  end

  def edit
    if @work.nil?
      flash[:warning] = "Work not found"
      redirect_to root_path
      return
    end
  end

  def update
    if @work.nil?
      flash[:warning] = "Work not found"
      redirect_to root_path
    elsif @work.update(work_params)
      flash[:success] = "#{@work.category.capitalize} successfully updated"
      redirect_to work_path
      return
    else
      flash.now[:failure] = "A problem occurred: could not update #{@work.category}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    if @work.nil?
      flash[:warning] = "Work not found"
      redirect_to root_path
      return
    else
      @work.destroy
      flash[:success] = "#{@work.category.capitalize} successfully deleted"
      redirect_to works_path
      return
    end
  end

  def main
    @spotlight = Work.spotlight
    @albums = Work.top_works("album")
    @books = Work.top_works("book")
    @movies = Work.top_works("movie")
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end
