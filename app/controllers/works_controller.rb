class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      # Change this to a 404 page
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save # returns true if db insert succeeds
      flash[:success] = "Your #{@work.category} has been added successfully to the ranker"
      redirect_to work_path(@work.id) # @work or @work.id?
      return
    else
      flash.now[:error] = "Something's gone awry. Your #{@work.category} hasn't been added"
      render :new, status: :bad_request # look at bad_request
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end

end
