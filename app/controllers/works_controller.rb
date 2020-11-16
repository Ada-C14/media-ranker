class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Work.albums
    @movies = Work.movies
    @books = Work.books
  end

  def show
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to root_path
      return
    end
    render :show
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params) #instantiate a new work
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "#{@work.category.capitalize} has been added successfully"
      redirect_to work_path(@work.id) # go to the index so we can see the work in the list
    else # save failed :(
      flash.now[:error] = "Oops! Something went wrong. #{@work.category.capitalize} was not added"
      render :new # show the new work form view again
    end
  end

  def edit
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to root_path
      return
    end
  end

  def update
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to root_path
      return
    elsif @work.update(work_params)
      flash[:success] = "#{@work.category.capitalize} updated!"
      redirect_to work_path
      return
    else
      flash.now[:failure] = "Oops! Something went wrong. Update failed #{@work.category}"
      render :edit
      return
    end
  end

  def destroy
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to root_path
      return
    else
      @work.destroy
      flash[:success] = "#{@work.category.capitalize} successfully deleted"
      redirect_to works_path
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :creator, :publication_date, :category)
  end

  def find_work
    @work = current_user.works.find(params[:id])
  end

end
