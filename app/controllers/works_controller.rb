class WorksController < ApplicationController
  before_action :find_work, only: [:destroy, :show, :edit, :update]


  def index
    @works = Work.all
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new
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
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit, status: :bad_request
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
      redirect_to homepage_path
      return
    end
  end


  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
    return @work
  end
end
