class WorksController < ApplicationController

  def index
    @works_book = Work.where(category: 'book')
    @works_album = Work.where(category: 'album')
    @works_movie = Work.where(category: 'movie')
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    #instantiate a new book
    if @work.save
      redirect_to works_path
      return
    else # save failed :(
      render :new, status: :bad_request
      return
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
