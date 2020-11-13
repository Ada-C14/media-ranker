class WorksController < ApplicationController
  def index
    @works = Work.all
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")

    @top_books = @books.top_ten('book')
    @top_albums = @albums.top_ten('album')
    @top_movies = @movies.top_ten('movie')
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to work_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(works_param)

    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      render :new
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
      redirect_to works_path
      return
    else
      @work.update(works_param)
      redirect_to works_path
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    elsif
      @work.destroy
      redirect_to works_path
    end
  end

  private

  def works_param
    return params.require(:work).permit(:id, :category, :title, :creator, :publication_year, :description)
  end
end
