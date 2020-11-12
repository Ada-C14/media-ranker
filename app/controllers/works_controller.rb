class WorksController < ApplicationController
  def index
    @works = Work.all
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")

    @top_books = @books.top_ten(category: 'book')
    @top_albums = @albums.top_ten(category: 'album')
    @top_movies = @movies.top_ten(category: 'movie')
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

    if @works.save
      redirect_to work_path(@work.id)
      return
    else
      render :new
    end
  end

  private

  def works_params
    return params.require(:works).permit(:id, :category, :title, :creator, :publication_year, :description)
  end
end
