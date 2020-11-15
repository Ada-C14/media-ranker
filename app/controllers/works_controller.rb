class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      redirect_to works_path
    end
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
    puts @work.inspect
    puts @work.valid?
    if @work.save
      redirect_to works_path
      flash[:success] = "#{@work.title} was successfully added!"
      return
    else
      flash.now[:error] = "Something happened. Media not added."
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
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to works_path
      return
      render :edit
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      redirect_to homepages_path
      return
    end
  end

  def vote
    work = Work.find_by(id: params[:id])
    user = User.find_by(id: session[:user_id])
    if work.nil?
      flash[:error] = "Not a valid work"
    end
    if user.nil?
      flash[:error] = "You must be logged in to vote"
    end
    vote = Vote.new(params[user_id: user, work_id: work])
    if vote.save
      flash[:success] = "Your vote was counted"
      redirect_to work_path
    else
      flash[:error] = "You have already voted"
      redirect_to work_path
    end
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end

