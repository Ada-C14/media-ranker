class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :current_user, only: [:upvote]

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
    if @work.nil?
      flash[:warning] = "Work not found"
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
      errors = {}
      @work.errors.each do |column, message|
        errors[column] = message
      end
      flash[:warning] = errors
      render :new, status: :bad_request and return
    end
  end

  def edit
    if @work.nil?
      flash[:warning] = "Work not found"
      redirect_to works_path and return
    end
  end

  def update
    if @work.nil?
      flash[:warning] = "Work not found"
      redirect_to works_path and return
    elsif @work.update(works_params)
      flash[:success] = "Your work has been updated"
      redirect_to work_path(@work) and return
    else
      errors = {}
      @work.errors.each do |column, message|
        errors[column] = message
      end
      flash[:warning] = errors
      render :edit, status: :bad_request and return
    end
  end

  def destroy
    if @work
      @work.destroy
      flash[:success] = "#{@work.title} has been deleted"
      redirect_to works_path and return
    else
      flash[:warning] = "#{@work.title} could not be deleted"
      redirect_to works_path and return
    end
  end

  def upvote
    # @user = current_user
    if @user.nil?
      flash[:warning] = "Please log in to vote"
      redirect_to work_path(@work) and return
    elsif @user.works.include?(@work)
      flash[:warning] = "You have already voted on this work"
      redirect_to work_path(@work) and return
    end

    @vote = Vote.new(user: @user, work: @work)

    if @vote.save
      flash[:success] = "Thank you, your vote has been tallied!"
    else
      flash[:warning] = "Sorry, something went wrong"
    end

    redirect_back fallback_location: root_path and return
  end

  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
