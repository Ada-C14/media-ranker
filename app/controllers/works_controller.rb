class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    # @works = Work.all
    @albums = Work.albums
    @movies = Work.movies
    @books = Work.books

  end

  def show
    if @work.nil?
      redirect_to works_path
      return
    elsif !Work.exists?(work_id)
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
      flash[:success] = "Book added successfully"
      redirect_to work_path(@work.id) # go to the index so we can see the work in the list
    else # save failed :(
      flash.now[:error] = "Something happened. Book not added."
      render :new # show the new work form view again
    end
  end

  def edit
    redirect_to root_path if @work.nil?
  end

  def update
    if @work.nil?
      redirect_to root_path
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    if @work
      @work.destroy
      redirect_to root_path
    else
      head :not_found
    end
  end

  def upvote
    if @work.nil?
      redirect_to root_path
      return
    elsif !Work.exists?(work_id)
      redirect_to root_path
      flash[:error] = "This work does not exist."
      return
    elsif Vote.exists?(session[:user_id], work_id)
      redirect_to root_path
      flash[:error] = "You have already voted for this work."
    else
      @vote = Vote.new(user_id: session[:user_id], work_id: work_id)
      @vote.save
      render :show
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
