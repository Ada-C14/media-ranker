class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work has been submitted"
      redirect_to work_path(@work.id)
    else
      flash[:error] = "Work has not been saved"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path
      return
    elsif @work.update(work_params)
      flash[:success] = "work updated successfully"
      redirect_to work_path
      return
    else
      flash.now[:error] = "Something happened. work not updated."
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:error] = "Work not found"
      redirect_to works_path
      return
    else
      flash[:success] = "Work has been deleted"
      @work.destroy
      redirect_to works_path
    end
  end

  def upvote

  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
