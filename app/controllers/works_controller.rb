class WorksController < ApplicationController

  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
    @movies = Work.sorted("movie")
    @albums = Work.sorted("album")
    @books = Work.sorted("book")
  end

  def show
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
      flash.now[:success] = "Successfully created  #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      @work.errors.each do |column, message|
        flash.now[:error] = "A problem occurred: Could not#{action_name} #{@work.category} #{column}: #{message}!"
      end
      render :new, status: :bad_request
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Succesfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      render :edit, status: :bad_request
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def destroy

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to root_path
    end
  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end

end
