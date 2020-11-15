class WorksController < ApplicationController
  # before_action :set_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @books = Work.books
    @albums = Work.albums
    @movies = Work.movies
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save 
      flash[:success] = "You created a new #{@work.category}"
      redirect_to works_path(@work.id)
      return
    else
      flash.now[:error] = "Work was not created, please try again!"
      render :new
      return
    end
  end

  def update
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash.now[:error] = "Work was not found"
      redirect_to works_path
      return 
    elsif @work.update(work_params)
      flash[:success] = "#{@work.title} was successfully updated."
      redirect_to works_path
      return
    else
      render :edit
    end
  end

  def destroy
    if @work.nil?
      flash.now[:error] = "Work was not found"
      redirect_to works_path
      return
    else
      @work.destroy 
      redirect_to works_path
      return
    end
  end

  def 
  private
    
    def work_params
      return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
    end
end
