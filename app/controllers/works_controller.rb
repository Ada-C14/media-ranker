class WorksController < ApplicationController
  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def show
    id = params[:id]
    @work = Work.find_by(id: id)
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params) #instantiate a new work
    if @work.save # save returns true if the database insert succeeds
      success_message = "Successfully created #{@work.category} #{@work.id}"
      flash_success(success_message)

      redirect_to work_path(@work) # goes to work page
      return
    else # save failed
      warning_message = "A problem occurred: Could not create work"
      flash_warning(warning_message, @work)

      render :new # show the new work form view again
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      success_message = "Successfully updated #{@work.category} #{@work.id}"
      flash_success(success_message)

      redirect_to work_path(@work) # goes to work page
      return
    else # save failed
      warning_message = "A problem occurred: Could not update #{@work.category}"
      flash_warning(warning_message, @work)

      render :edit # show the new book form view again
      return
    end
  end

  def destroy
    id = params[:id]
    @work = Work.find_by(id: id)
    if @work.nil?
      head :not_found
      return
    end

    @work.destroy
    success_message = "Successfully destroyed #{@work.category} #{@work.id}"
    flash_success(success_message)
    redirect_to root_path
    return
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :publication_year, :creator, :category)
  end
end
