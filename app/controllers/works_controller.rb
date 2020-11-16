class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :find_session, only: [:upvote] #TODO: I don't see why I would put this in app. controller if the heroku model only requires login for upvoting? So I put it here

  def index
    @works = Work.all
  end

  def show
    # find_work
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    # find_work

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    # find_work

    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    # find_work

    @work.destroy
    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"

    #TODO: If work not found
    redirect_to root_path
  end

  def upvote
    # find_session

    vote = Vote.create(user_id: @user.id, work_id: @work.id)

    if vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@work)
    else
      flash[:warning] = "Could not upvote"
      flash[:messages] = vote.errors.messages
      # flash[:messages] = vote.errors.messages
      redirect_back fallback_location: '/'
    end
  end

  private
  def work_params
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

  private

  def find_work
    @work = Work.find_by_id(params[:id])
    head :not_found if !@work
    return
  end

  def find_session
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_to work_path(@work.id)
      return
    else
      return
    end
  end

  #TODO: not sure why I would use a login filter when the heroku website only blocks a user from doing one action
  # without logging in: upvoting?  Perhaps I am missing something, but seems impractical and actually NOT dry.
end
