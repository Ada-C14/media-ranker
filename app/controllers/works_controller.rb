class WorksController < ApplicationController

  def top
    @spotlight = Work.spotlight
    @top_books = Work.top_books
    @top_movies = Work.top_movies
    @top_albums = Work.top_albums
  end


  def index
    @works = Work.all
    @books = Work.books
    @movies = Work.movies
    @albums = Work.albums
  end

  def show
    @work = find_by_id

    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "#{@work.category.capitalize} was successfully added!"
      redirect_to work_path(@work)
      return
    else
      flash.now[:failure] = "#{@work.title} was not successfully added."
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = find_by_id

    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = find_by_id

    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "#{@work.category.capitalize} was successfully updated!"
      redirect_to work_path(@work)
      return
    else
      flash.now[:failure] = "#{@work.title} was not successfully updated."
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = find_by_id

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      redirect_to works_path
    end
  end

  # helper method
  def find_by_id
    work_id = params[:id].to_i
    work = Work.find_by(id: work_id)
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :published, :description)
  end
end
