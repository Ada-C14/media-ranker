class WorksController < ApplicationController

  def index
    @works = Work.all

    @albums = @works.where(media: 'album')
    @books = @works.where(media: 'book')
    @movies = @works.where(media: 'movie')
  end

  def show
    id = params[:id]
    @work = Work.find_by(id: id)

    if @work.nil?
      redirect_to works_path and return
    end
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
      flash.now[:error] = "Something happened. Media not added."
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id:params[:id])

    if @work.nil?
      redirect_to work_path
      return
    end
  end

  def update
    @work = Work.find_by(id:params[:id])

    if @work.nil?
      redirect_to work_path
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id:work_id)

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      redirect_to works_path
    end
  end

end

private

def work_params
  params.require(:work).permit( :media, :title, :created_by, :published, :description)
end


