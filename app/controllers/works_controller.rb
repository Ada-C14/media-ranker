class WorksController < ApplicationController
  def index
    @works = Work.all

    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path and return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(works_params)

    if @work.save
      flash[:success] = "Work added to the ranker"
      redirect_to work_path(@work) and return
    else
      flash[:error] = "Sorry, the work was not saved"
      render :new, status: :bad_request and return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path and return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path and return
    elsif @work.update(works_params)
      flash[:success] = "Your work has been updated"
      redirect_to work_path(@work) and return
    else
      flash[:error] = "Sorry, your work was not updated"
      render :edit, status: :bad_request and return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work
      @work.destroy
      flash[:success] = "The work has been deleted"
      redirect_to works_path and return
    else
      flash[:error] = "The work could not be deleted"
      redirect_to works_path and return
    end
  end

  def upvote
    @work = Work.find_by(id: params[:id])
    user_id = session[:user_id]

    @vote = @work.upvote(user_id)

    if @vote.save
      flash[:success] = "Thank you, your vote has been tallied!"
    else
      flash.now[:error] = "Sorry, something went wrong"
    end

    redirect_back fallback_location: root_path and return

    # route this to the vote model upvote method
    # to handle all of the business logic
    # passing in the params[:id] as an argument?
  end

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
