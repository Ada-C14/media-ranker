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

    if @work.save
      redirect_to work_path(@work.id)
      flash[:success] = "#{@work.title} was successfully added!"
      return
    else
      #when doing a render, use flash.now
      flash.now[:error] = "Uh Oh! Could not create new work."
      render :new, status: :bad_request

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
      redirect_to work_path(@work.id)
      flash[:success] = "Created: #{@work.category}: #{@work.title}"
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

