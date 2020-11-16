class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

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
      redirect_to work_path(@work.id)
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    if @work
      @work.destroy
      redirect_to works_path
      return
    else
      head :not_found
      return
    end
  end

  def upvote
    if session[:user_id]
      @vote = Vote.new(work_id: params[:id], user_id: session[:user_id])
      if @vote.save
        flash[:success] = "Successfully upvoted"
      else
        @vote.errors.each do |column, message|
          flash[:error] = message
        end
      end
    else
      flash[:error] = "You must be logged in to upvote!"
    end
    redirect_back fallback_location: '/'
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end
