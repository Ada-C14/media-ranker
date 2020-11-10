class WorksController < ApplicationController
  # Helper Methods
  def work_not_found_error_notice
    flash[:notice] = "Uh oh! That work does not exist..."
    redirect_to work_path
  end

  #########################################################

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
    if @work.nil?
      work_not_found_error_notice
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
