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
      head :not_found
      return
    elsif @work.update(work_params)
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
      redirect_to works_path
    else
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
      return
    end
  end

  private

  def work_params
      return params.require(:work).permit(:category, :name, :title, :creator, :publication_year, :description)
  end

end
