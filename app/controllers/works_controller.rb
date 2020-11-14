class WorksController < ApplicationController
  def index
    @works = Work.all
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")

    @top_books = @books.top_ten('book')
    @top_albums = @albums.top_ten('album')
    @top_movies = @movies.top_ten('movie')
    @user = User.find_by(id: session[:user_id])
    @username = @user.username
  end

  def show
    @work = Work.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    @username = @user.username

    if @work.nil?
      redirect_to work_path
      return
    end
  end

  def new
    @work = Work.new
    @user = User.find_by(id: session[:user_id])
    @username = @user.username
  end

  def create
    @work = Work.new(works_param)

    if @work.save
      flash[:success] = "Your #{@work.category} was added successfully!"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Oops! Media was not added."
      render :new
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    else
      @work.update(works_param)
      redirect_to works_path
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

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
end
