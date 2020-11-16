class WorksController < ApplicationController

  skip_before_action :require_login , except: [:upvote]

  before_action :find_work, only: [:show, :update, :edit, :destroy]

  def index
    @books = Work.category_organized('book')
    @albums = Work.category_organized('album')
    @movies = Work.category_organized('movie')
  end

  def show
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    if @work.nil?
      flash.now[:error] = "Something happened. Work not updated."
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Work successfully updated"
      redirect_to works_path
      return
    else
      render :edit
      return
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def destroy
    if @work
      @work.destroy
      flash[:success] = "Work successfully deleted"
      redirect_to works_path
    else
      flash.now[:error] = "Something happened. Work not deleted."
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Something happened. Work not added."
      render :new, status: :bad_request
      return
    end
  end

  def upvote
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      @vote = Vote.create(user: user)
    else
      flash.now[:error] = "Something happened. User not found or not logged in."
      render :new, status: :bad_request
      return
    end

  end

  private

  def work_params
    return params.require(:work).permit(:category, :name, :title, :creator, :publication_year, :description)
  end

  def find_work
    id = params[:id].to_i
    @work = Work.find_by(id: id)
  end

end
