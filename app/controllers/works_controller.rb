class WorksController < ApplicationController
  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "Uh oh! That work does not exist..."
    redirect_to works_path
  end

  def not_saved_error_notice
    flash[:notice] = "Uh oh! That did not save correctly."
  end

  #########################################################

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
    if @work.nil?
      not_found_error_notice
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      not_saved_error_notice
      render :new
      return
    end
  end

  def edit
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      not_found_error_notice
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      not_found_error_notice
      return
    elsif @work.update(work_params)
      redirect_to work_path
      return
    else
      not_saved_error_notice
      render :edit
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      not_found_error_notice
      return
    else
      @work.destroy
      redirect_to works_path
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
