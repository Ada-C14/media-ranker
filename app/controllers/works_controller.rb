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

    #TODO: Add various flash messages
    if @work.save
      redirect_to work_path(@work)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    #TODO: Add various flash messages
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    #TODO: Add various flash messages
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
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

    #TODO: Add various flash messages
    redirect_to root_path
  end

  private
  def work_params
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

end
