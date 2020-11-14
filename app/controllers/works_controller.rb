class WorksController < ApplicationController
  def index
    @works =Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work)
      return
    else
      render :new
      return
    end
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by_id(params[:id])
    result = @work.update(work_params)

    if result
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end


  def destroy
    work = Work.find_by_id(params[:id])
    if work.nil?
      redirect_to works_path
      return
    end

    if work.destroy
      redirect_to works_path
    end
  end

  def top
  end

  def upvote
    @work = Work.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])

    if @user.nil?
      flash[:error] = "No user is signed in"
      redirect_to works_path
      return
    end

    if @work.nil?
      flash[:error] = "No work provided"
      redirect_to works_path
      return
    end

    vote = Vote.new(work: @work , user: @user)
    if vote.save
      flash[:welcome] = "You just upvoted this work"
    else
      flash[:error] = "You already voted for this work"
    end
    redirect_to works_path
  end

  private
  
  def work_params
    return params.require(:work).permit(:title, :description, :publication_year, :creator, :category)
  end


end
