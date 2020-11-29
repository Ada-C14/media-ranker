class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :require_login, only: [:upvote]

  def index
    @works = Work.all
    @albums = Work.sorted_media("album")
    @books = Work.sorted_media("book")
    @movies = Work.sorted_media("movie")
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)
    if @work.save 
      flash[:success] = "You created a new #{@work.category}"
      redirect_to works_path(@work.id)
      return
    else
      flash.now[:error] = "Something happened. Work was not created, please try again!"
      render :new
      return
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "#{@work.title} was successfully updated."
      redirect_to @work
      return
    else
      flash.now[:error] = "Work was not updated"
      render :edit
      return
    end
  end

  def destroy
      @work.destroy 
      flash.now[:notice] = "You have successfully deleted #{@work.title}"
      redirect_to works_path
      return
  end

  # Custom method
  def upvote
    # if session[:user_id]
    #   user = current_user
      @vote = Vote.new(user_id: @current_user.id, work_id: @work.id)
      if @vote.save
        flash[:success] = "Your vote for #{@work.title} was successfully recorded."
        redirect_to works_path
        return
      else 
        flash[:danger] = "Voting for the same work is currently disallowed" 
        redirect_to works_path
        return
      end
  end
  
  private
  
    # Share common setups/constraints between actions
    def set_work
      @work = Work.find_by(id: params[:id])

      if @work.nil?
        head :not_found
        return
      end

    end

    # Only permit trusted parameters to be passed in. 
    def work_params
      return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :votes_count)
    end
end
