class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to works_path
      return
    end
    render :show
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save # save returns true if the database insert succeeds
      flash[:success] = "#{@work.category.capitalize} has been added successfully"
      redirect_to work_path(@work.id) # go to the index so we can see the work in the list
    else # save failed :(
      flash.now[:error] = "Oops! Something went wrong. #{@work.category.capitalize} was not added"
      render :new # show the new work form view again
    end
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to root_path
      return
    end
  end

  def update
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to root_path
      return
    elsif @work.update(work_params)
      flash[:success] = "#{@work.category.capitalize} updated!"
      redirect_to work_path
      return
    else
      flash.now[:failure] = "Oops! Something went wrong. Update failed #{@work.category}"
      render :edit
      return
    end
  end

  def destroy
    if @work.nil?
      flash[:warning] = "This particular work does not exist"
      redirect_to root_path
      return
    else
      @work.destroy
      flash[:success] = "#{@work.category.capitalize} successfully deleted"
      redirect_to works_path
      return
    end
  end

  # Custom method

  def upvote
    @work = Work.find_by_id(params[:id])
    @user = User.find_by_id(session[:user_id])
    if @user.nil?
      flash[:error] = "Missing user"
      redirect_to works_path
      return
    end
    if @work.nil?
      flash[:error] = "Missing work"
      redirect_to works_path
      return
    end
    vote = Vote.new(work: @work, user: @user)
    if vote.save
      flash[:success] = "You just voted this work"
    else
      flash[:error] = "Oops! You may upvote a work only one time."
    end
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :creator, :publication_date, :category)
  end

end
