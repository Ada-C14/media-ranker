class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work added successfully"
      redirect_to root_path
      return
    else
      flash.now[:error] = "Something happened. Work not added."
      render :new, status: :bad_request
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
