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
      flash[:success] = "#{@work.title} was successfully created!"
      redirect_to work_path @work.id
      return
    else
      flash.now[:error] = "#{@work.title} was NOT added"
      render :new, status: :bad_request #shows a new work form again
    return
    end
  end

  def top
    @top_albums = Work.top_by_category("album")
    @top_movies = Work.top_by_category("movie")
    @top_books = Work.top_by_category("book")

    @spotlight = Work.spotlight
  end

  def edit
  end

  def update
  end

  private
  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_date, :description)
  end

end
