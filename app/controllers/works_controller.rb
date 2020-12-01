class WorksController < ApplicationController

  before_action :require_login, except: [:homepage, :index, :show]
  before_action :find_work, except: [:homepage, :index, :new]

  def homepage
    @works = Work.all
  end

  # def list
  #   @albums = Work.list_albums
  # end

  def index
    @works = Work.all
  end

  def show
    # work_id = params[:id].to_i
    # @work = Work.find_by(id: work_id)
    if @work.nil?
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
      return
    else
      flash.now[:error] = "Something happened. Work not added."
      render :new, status: :bad_request
      return
    end
  end

  def update
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Work updated successfully"
      redirect_to works_path  
      return
    else  
      flash.now[:error] = "Something happened. Work not updated."
      render :edit, status: :bad_request  
      return
    end
  end

  def edit
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def destroy
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    else
      @work.destroy
      redirect_to works_path
    end
  end

  def upvote
    vote = Vote.new(user_id: @login_user.id, work_id: @work.id)

    if vote.save
      flash[:success] = "Successfully upvoted #{@work.title}"
    else
      flash[:error] = "Something went wrong. Could not upvote #{@work.title}"
    end

    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
  end
end
