class WorksController < ApplicationController

  def order_list(category)
    return Work.where(category: category).order(votes_count: :desc, created_at: :asc)
  end

  def index
    @works = Work.all

    @albums = order_list("album")
    @books = order_list("book")
    @movies = order_list("movie")
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
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "Please log in to vote"
      redirect_to work_path(@work) and return
    elsif @user.works.include?(@work)
      flash[:error] = "You have already voted on this work"
      redirect_to work_path(@work) and return
    end

    @vote = Vote.new(user: @user, work: @work)

    if @vote.save
      flash[:success] = "Thank you, your vote has been tallied!"
    else
      flash[:error] = "Sorry, something went wrong"
    end

    redirect_back fallback_location: root_path and return
  end

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
