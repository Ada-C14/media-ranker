class WorksController < ApplicationController
  def index
    @books = Work.works_in_category("book")
    @movies = Work.works_in_category("movie")
    @albums = Work.works_in_category("album")
  end

  def show
    @work = Work.find(params[:id])
    if @work.nil?
      # redirect_to works_path
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
      flash[:success] = "#{@work.title.titleize} was successfully created :)"
      redirect_to work_path(@work.id)
      return
    else
      flash[:error] = "#{@work.title.titleize} was NOT successfully created :( Please fill in ALL fields."
      render :new #, status: :not_found
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash.now[:error] = "#{@work.title.titleize} was NOT successfully edited :("
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "#{@work.title.titleize} was successfully edited :)"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "You need to enter data in all fields"
      render :edit
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id:work_id)

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      flash[:success] = "#{@work.title.titleize} was successfully deleted :)"
      redirect_to works_path
    end
  end


  def upvote
    @work = Work.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:notice] = "You must be logged in!"
      redirect_to(login_path)
    else
    # vote = @work.votes.new(user: @user)
      vote = Vote.new(work: @work, user: @user)
      if vote.save
        flash[:notice] =  "Thank you for upvoting!"
        redirect_to(works_path)
      else
        flash[:notice] =  "You have already upvoted this!"
        redirect_to(works_path)
      end
    end
  end

  # form relation/link between user & work
  # create a new vote and save it with usr_id and work_id

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
