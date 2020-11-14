class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :find_current_user, only: [:upvote]

  def index
    @work_hash = Hash[Work.work_hash.sort]
  end

  def show
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
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
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
    # NOTE: confirmation page is handled by index and show pages as a dialog box.
    if @work
      cat = @work.category
      id = @work.id
      @work.destroy
      flash[:success] = "Successfully destroyed #{cat} #{id}"
      redirect_to root_path
    else
      head :not_found
      return
    end
  end

  # custom method to upvote
  # NEEDS TESTS
  def upvote
    if @user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
    else
      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
      if @vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "A problem occurred: Could not upvote"
        flash[:error_messages] = @vote.errors.messages
      end
    end
    redirect_back fallback_location: works_path
    return
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end
