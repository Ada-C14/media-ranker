class WorksController < ApplicationController
  def index
    @books = Work.where(category: 'book').sample(10)
    @movies = Work.where(category: 'movie').sample(10)
    @albums = Work.where(category: 'album').sample(10)
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    else
      @users = @work.users
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end

    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    # NOTE: confirmation page is handled by index and show pages as a dialog box.
    if @work
      cat = @work.category
      @work.destroy
      flash[:success] = "Successfully destroyed #{cat} #{work_id}"
      redirect_to root_path
    else
      head :not_found
      return
    end
  end

  # custom method to upvote
  # NEEDS TESTS
  def upvote
    if session[:user_id].nil?
      flash[:error] = "A problem occurred: You must log in to do that"
    else
      user_id = session[:user_id]
      work_id = params[:id]
      @vote = Vote.new(user_id: user_id, work_id: work_id)
      if @vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "A problem occurred: Could not upvote"
        flash[:error_messages] = @vote.errors.messages
      end
    end
    redirect_to request.referrer
    return
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
