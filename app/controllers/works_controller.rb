class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"
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
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:warning] = "A problem occurred: Could not update #{@work.category}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    else
      #TODO flash displays after a redirect + another request

      flash[:success] = "Successfully deleted #{@work.category} #{@work.id}"
      @work.destroy
      redirect_to root_path
    end
  end

  def upvote
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:warning] = "A problem occurred: Work not found"
      redirect_to work_path(params[:id])
      return
    end
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_to work_path(@work.id)
      return
    end
    @vote = Vote.new(user_id: user.id, work_id: @work.id)
    # @work.votes << @vote

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "A problem occurred: Could not upvote"
      p "ERRORS" # TODO: REMOVE
      # @work.errors[:messages] << { :user => [ "has already voted for this work" ] }
      p @vote.errors # TODO: REMOVE
      redirect_to work_path(@work.id)
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
