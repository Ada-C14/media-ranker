class WorksController < ApplicationController

  before_action :find_work, except: [:index, :new, :create]

  def index
    @works = Work.all.order(title: :asc)
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def show
    if @work.nil?
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.nil? # form will not allow user to save, but for some reason is not getting flash
      flash[:error] = "Uh Oh! Could not create new work."
      render :new, status: :bad_request

    else @work.save
      flash[:success] = "#{@work.title} was successfully added!"
      redirect_to work_path(@work.id)
      return
    end
  end

  def edit
    if @work.nil?
      redirect_to root_path
      flash[:error] = "Uh Oh! We couldn't find #{@work.title}"
      return
    end
  end

  def update
    if @work.nil?
      redirect_to work_path
      flash[:error] = "Uh Oh! We couldn't find #{@work.title}"
      return
    elsif @work.update(work_params)
      flash[:success] = "Updated: #{@work.category}: #{@work.title}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Uh Oh! We couldn't update #{@work.title}"
      render :edit
    return
    end
  end

  def delete
    if @work.nil?
      redirect_to works_path
      flash[:error] = "Uh Oh! We couldn't find #{@work.title}"
    else
      @work.delete
      redirect_to works_path
      flash[:success] = "POOF! You have deleted: #{@work.category}: #{@work.title}"
      return
    end
  end
end

private

def find_work
  @work = Work.find_by(id: params[:id])
end

def work_params
  params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end

