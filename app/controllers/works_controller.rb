class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path, status: :temporary_redirect
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "#{@work.title} was successfully added!"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: could not create #{@work.category}"
      render :new, status: :bad_request
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
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}!"
      redirect_to work_path(@work.id)
      return
    else # save failed :(
      flash.now[:error] = "A problem occurred: could not update #{@work.category}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "A problem occurred: could not update #{@work.category}"
      redirect_to works_path, head: :temporary_redirect
      return
    end


    @work.destroy

    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}!"
    redirect_to works_path
    return
  end

  def homepage
    @works = Work.all

    @spotlight = top_rated(@works)

    @books = Work.where(category: "book")
    @ranked_books = rank10(@books)

    @albums = Work.where(category: "album")
    @ranked_albums = rank10(@albums)

    @movies = Work.where(category: "movie")
    @ranked_movies = rank10(@movies)
  end

  def rank10(work_list)
    sorted_list = work_list.sort_by { |work| work.votes.count }.reverse

    return sorted_list.first(10)

  end

  def top_rated(work_list)
    sorted_list = work_list.sort_by { |work| work.votes.count }.reverse

    return sorted_list.first
  end


  def upvote
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])

    if user.nil?
      flash.now[:error] = "You must be logged in to vote on works"
      render work_path(work.id)
    end

    vote = Vote.new
    vote.user_id = user.id
    vote.work_id = work.id

    if vote.save

    end


  end


  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
