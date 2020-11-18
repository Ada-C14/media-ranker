class WorksController < ApplicationController

  before_action :find_by, except: [:index, :new, :create]
  before_action :find_user

  def index
    @works = Work.all
    @albums = @works.where(category: "album")
    @books = @works.where(category: "book")
    @movies = @works.where(category: "movie")
  end

  def show
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def top_works
    @works = Work.all

    @work = @works.sample

    @albums = @works.where(category: 'album').sample(10)
    @books = @works.where(category: 'book').sample(10)
    @movies = @works.where(category: 'movie').sample(10)

  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Something happened. Work not added."
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
      redirect_to works_path
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy

    if @work
      @work.destroy
      redirect_to works_path
    else
      head :not_found
    end
    return

  end

  private

  def find_by
    @work = Work.find_by(id: params[:id])
  end

  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def work_params
    params.require(:work).permit(:title, :description, :publication_date, :creator, :category)
  end

end
