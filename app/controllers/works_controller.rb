class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Work.all.where(category: "album")
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def show
    if @work.nil?
      head :not_found
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}. #{@work.errors.messages}"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    if @work.nil?
      head :not_found
      return
    end

    @work.destroy
    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
    redirect_to root_path
  end

  def upvote
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:id])

    if user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to works_path
      return
    end

    if work.nil?
      flash[:error] = "A problem occurred: Could not find work"
      redirect_to works_path
      return
    end

    vote = Vote.new(user: user, work: work)

    if vote.save
      flash[:success] = "Successfully upvoted!"
    else
      flash[:error] = "A problem occurred: Could not upvote"
      flash[:error_messages] = vote.errors.values.flatten.join("\n")
    end

    redirect_to work_path(params[:id])
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
