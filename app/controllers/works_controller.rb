class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    #create a new work
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
      return
    else
    render :new, status: :bad_request #shows new work form again
    return
    end
  end

  def top
    @top_albums = Work.top_by_category("movie")
    @top_movies = Work.top_by_category("book")
    @top_books = Work.top_by_category("album")

    @spotlight = Work.spotlight

    # if @top_albums.nil?
    #   head :not_found
    #   return
    # end
    # if @top_movies.nil?
    #   head :not_found
    #   return
    # end
    # if @top_books.nil?
    #   head :not_found
    #   return
    # end

  end

  private
  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_date, :description)
  end

end
