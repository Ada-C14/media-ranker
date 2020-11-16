class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy, :upvote]

  def index
    @works = Work.all
  end

  def show
    if @work.nil?
      redirect_to work_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(works_param)

    if @work.save
      flash[:success] = "Your #{@work.category} was added successfully!"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Oops! Media already exists."
      render :new
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
      redirect_to works_path
      return
    else
      @work.update(works_param)
      redirect_to works_path
    end
  end

  def destroy
    if @work.nil?
      redirect_to works_path
      return
    elsif
      @work.destroy
      redirect_to works_path
    end
  end

  def upvote
    @vote = Vote.all.find_by(work_id: params[:work_id], user_id: session[:user_id])

    if @vote.nil?
      Vote.create(work_id: params[:work_id], user_id: session[:user_id])
      flash[:success] = "Successfully voted!"
      redirect_back fallback_location: '/'
      return
    else
      flash[:error] = "Already voted for this work."
      redirect_back fallback_location: '/'
      #Why won't redirect_to work_path work?
      return
    end
  end

  private

  def works_param
    return params.require(:work).permit(:id, :category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
