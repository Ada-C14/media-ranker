class WorksController < ApplicationController
  def index
    # @works = Works.all
  end

  def show
    # @work = Work.find_by(id: params[:id])
    # return :not_found if @work.nil?
  end

  def new
    # @work = Work.new
  end

  def create
    # work = Work.new(work_params)
    # return work.save ? redirect_to work_path(work) : render :new, status: :bad_request
  end

  def edit
    # @work = Work.find_by(id: params[:id])
    # return redirect_to root_path if @work.nil?
  end

  def update
    # work = Work.find_by(id: params[:id])
    # if work.nil?
    #   head :not_found
    #   return
    # elsif work.update(work_params)
    #   redirect_to work_path(work.id)
    #   return
    # else
    #   redirect_to root_path
    # end
  end

  def destroy
    # work = Work.find_by(id: params[:id])
    # if work.nil?
    #   head :not_found
    #   return
    # else
    #   work.destroy
    #   redirect_to drivers_path
    # end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
