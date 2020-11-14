class WorksController < ApplicationController

  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "That media does not exist."
    redirect_to works_path
  end

  def not_saved_error_notice
    flash.now[:notice] = "Something happened. Media not added. Please try again."
  end

  def saved_notice
    flash[:success] = "Media added successfully"
  end

  def already_voted
    flash[:notice] = "You already voted to this media"
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
      redirect_to work_path
      return
    else
      not_saved_error_notice
      render edit
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
      redirect_to work_path
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
      already_voted
    else
      Vote.create!(user:@user, work:@work)
    end

    redirect_to works_path
  end
end