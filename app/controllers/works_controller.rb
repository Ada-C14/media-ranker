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
      flash[:success] = "Created: #{@work.category}, ID: #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Uh Oh! Could not create #{@work.category}"
      render new_work_path
      return
    end
  end

  def edit
    if @work.nil?
      flash.now[:error] = "Uh Oh! We couldn't find #{@work.category}"
      redirect_to root_path
      return
    end
  end

  def update
    if @work.nil?
      flash.now[:error] = "Uh Oh! We couldn't find #{@work.category}"
      redirect_to work_path
      return
    elsif @work.update(work_params)
      flash[:success] = "Created: #{@work.category}: #{@work.title}"
      redirect_to work_path(@work.id)
      return
    else # save failed
    flash.now[:error] = "Uh Oh! We couldn't update #{@work.category}"
    render :edit
    return
    end
  end

  def destroy
    if @work.nil?
      flash.now[:error] = "Uh Oh! We couldn't find #{@work.category}"
      redirect_to works_path
    else
      @work.destroy
      flash[:success] = "POOF! You have deleted: #{@work.category}: #{@work.title}"
      redirect_to root_path
      return
    end
  end
end
