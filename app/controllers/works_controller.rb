class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      flash.now[:error] = "Something happened. Work not updated."
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Work successfully updated"
      redirect_to works_path
      return
    else
      render :edit
      return
    end
  end

  def edit
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work.nil?
      head :not_found
      return
    end
  end

  def destroy
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    if @work
      @work.destroy
      flash[:success] = "Work successfully deleted"
      redirect_to works_path
    else
      flash.now[:error] = "Something happened. Work not deleted."
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
      flash[:success] = "Work added successfully"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Something happened. Work not added."
      render :new, status: :bad_request
      return
    end
  end

  private

  def work_params
      return params.require(:work).permit(:category, :name, :title, :creator, :publication_year, :description)
  end

end
