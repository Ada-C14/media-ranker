class WorksController < ApplicationController

  before_action :find_work, except: [:index, :new, :create]

  def index
    @works = Work.all.order(title: :asc)
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def show
    #find_work method runs, finds the specific work and routes us to the specific show page
    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    # instantiate a new instance of work, not saved until the save method is called; which usually happens in create method.
    @work = Work.new
  end

  def create
    # Create does the same as new, but also saves it to the database.
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category}, ID: #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render new_work_path
      return
    end
  end

  def edit
    if @work.nil?
      flash.now[:error] = "A problem occurred: Could not find #{@work.category}"
      redirect_to root_path
      return
    end
  end

  def update
    if @work.nil?
      flash.now[:error] = "A problem occurred: Could not find #{@work.category}"
      redirect_to work_path
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated the #{@work.category}: #{@work.title}"
      redirect_to work_path(@work.id)
      # stays on specific work page to show update.
      return
    else # save failed
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      # show the new work form view again
      render :edit
      return
    end
  end

  def destroy
    if @work.nil?
      flash.now[:error] = "A problem occurred: Could not find #{@work.category}"
      redirect_to works_path
    else
      @work.destroy
      flash[:success] = "Successfully deleted the #{@work.category}: #{@work.title}"
      redirect_to root_path
      return
    end
  end


  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
