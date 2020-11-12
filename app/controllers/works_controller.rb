class WorksController < ApplicationController
  def index
    @works =Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
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
      redirect_to work_path(@work)
      return
    else
      render :new
      return
    end
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find(params[:id])
    result = @work.update(work_params)

    if result
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end


  def destroy
    work = Work.find_by_id(params[:id])
    if work.nil?
      redirect_to works_path
      return
    end

    if work.destroy
      redirect_to works_path
    else
      #do a test
    end
  end

  def top
  end

  private
  
  def work_params
    return params.require(:work).permit(:title, :description, :publication_year, :creator, :category)
  end

end
