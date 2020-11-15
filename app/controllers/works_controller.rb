class WorksController < ApplicationController

  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "That media does not exist."
  end

  def not_saved_error_notice
    flash.now[:notice] = "A problem occurred: Could not create #{@work.category} "
  end

  def saved_notice
    flash[:success] = "Successfully created #{@work.category}"
  end

  def already_voted_notice
    flash[:notice] = "user: has already voted for this work"
  end

  def successful_upvote_notice
    flash[:success] = "Successfully upvoted!"
  end

  def update_work_notice
    flash[:success] = "Successfully updated #{@work.category}"
  end

  def destroyed_notice
    flash[:success] = "Successfully destroyed #{@work.category}"
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  #########################################################

  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by_id(work_id)

    if @work.nil?
      not_found_error_notice
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      saved_notice
      redirect_to work_path(@work.id)
      return
    else
      not_saved_error_notice
      render :new
      return
    end
  end

  def edit
    work_id = params[:id].to_i
    @work = Work.find_by_id(work_id)

    if @work.nil?
      not_found_error_notice
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      not_found_error_notice
      return
    elsif
      @work.update(work_params)
      update_work_notice
      redirect_to work_path
      return
    else
      not_saved_error_notice
      render :edit
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      not_found_error_notice
      return
    else
      @work.destroy
      destroyed_notice
      redirect_to works_path
      return
    end
  end

  def upvote
    session[:user_id]
    @work = Work.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])

    if @work.nil?
      not_found_error_notice
      return
    end
    if @user.nil?
      not_found_error_notice
      return
    end
    if Vote.find_by(user:@user, work:@work)
      already_voted_notice
    else
      Vote.create!(user:@user, work:@work)
      successful_upvote_notice
    end

    redirect_to work_path
  end
end