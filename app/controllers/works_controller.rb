class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
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
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new, status: :bad_request
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
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "work updated successfully"
      redirect_to work_path # go to the show so we can see the work
      return
    else # save failed :(
      flash.now[:error] = "Something happened. work not updated."
      render :edit, status: :bad_request # show the new work form view again
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    else
      @work.destroy
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
