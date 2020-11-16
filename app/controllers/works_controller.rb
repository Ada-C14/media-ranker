class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @works = Work.all
  end

  def show
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
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
      return
    else
      flash.now[:warning] = "A problem occurred: Could not update #{@work.category}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    if @work.nil?
      head :not_found
      return
    else
      flash[:success] = "Successfully deleted #{@work.category} #{@work.id}"
      @work.destroy
      redirect_to root_path
    end
  end

  def upvote
    if @work.nil?
      flash[:warning] = "A problem occurred: Work not found"
      redirect_back(fallback_location: work_path(params[:id]))
      return
    end

    if @current_user.nil?
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: work_path(@work.id))
      return
    end

    @vote = Vote.new(user_id: @current_user.id, work_id: @work.id)

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: work_path(@work.id))
      return
    else
      flash[:warning] = "A problem occurred: Could not upvote. User has already voted for this work."
      redirect_back(fallback_location: work_path(@work.id))
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end
