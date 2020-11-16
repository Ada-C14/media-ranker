class WorksController < ApplicationController

  before_action :find_work, only: [:edit, :update, :destroy, :upvote]

  def index
    @works = Work.all
    #NEED TO DRY THIS UP >>
    @all_movies = Work.total_lists(category: "movie")
    @all_books = Work.total_lists(category: "book")
    @all_albums = Work.total_lists(category: "album")
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
    #just added the user portion below
    @user = User.find_by(id: session[:user_id])
    @users = User.all
    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "#{@work.category} added successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}."
      render :new, status: :bad_request
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

  def update
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif  @work.update(work_params)
      flash[:success] = "This work was updated successfully"
      redirect_to work_path
      return
    else
      render :edit
    end
  end

  def destroy
    # work_id = params[:id]
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
    @work.destroy
    redirect_to works_path
    return
  end

  def upvote
    # @work = Work.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash.now[:error] = "Must be logged in to vote."
      render :show
      return
    elsif @work.votes.any? { |vote| vote.user_id == @user.id}
      flash.now[:error] = "Cannot vote for the same work twice."
      render :show
      return
    end

    if @work.nil?
      redirect_to(works_path)
    else
      Vote.create!(work: @work, user: @user)
      # @work.votes.create!(user: @user)
    render :show
    end

  end
  private

  def work_params
    return params.require(:work).permit(:title, :description, :publication_date, :creator, :category)
  end

  def find_work
    @work = Work.find_by(id: params[:id])

  end
end
