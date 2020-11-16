class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
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
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    @work.destroy
    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"

    #TODO: If work not found
    redirect_to root_path
  end

  def upvote

    @work = Work.find_by(id: params[:id])
    user = User.find_by(id: session[:user_id])

    if user.nil?
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_to work_path(@work.id)
      return
    end

    vote = Vote.create(user_id: user.id, work_id: @work.id)

    if vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@work)
    else
      flash[:warning] = "Could not upvote"
      redirect_back fallback_location: '/'
    end
  end

  private
  def work_params
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

end
