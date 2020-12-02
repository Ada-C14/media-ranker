class WorksController < ApplicationController

  before_action :require_login, only: [:upvote]
  before_action :find_work, except: [:homepage, :index]

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
      flash.now[:error] = "Something happened. Work not added."
      render :new, status: :bad_request
      return
    else
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to works_path
    end
  end

  def upvote
    if @work.votes.select {|vote| vote.user_id == @login_user.id}.count > 0
      flash[:error] = "Can't vote for #{@work.title} twice"
    else
      vote = Vote.new(user_id: @login_user.id, work_id: @work.id)
      if vote.save
        flash[:success] = "Successfully upvoted #{@work.title}"
      else
        flash[:error] = "Something went wrong. Could not upvote #{@work.title}"
      end
    end

    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :vote_count)
  end

  def find_work
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      flash.now[:error] = "Work not found!"
      render :index, status: :bad_request
    end
  end
end
