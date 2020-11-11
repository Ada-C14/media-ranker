class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)
    if @work.nil?
      redirect_to works_path
      return
    elsif !Work.exists?(work_id)
      redirect_to root_path
      return
    end
    render :show
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params) #instantiate a new work
    if @work.save # save returns true if the database insert succeeds
      redirect_to work_path(@work.id) # go to the index so we can see the work in the list
      return
    else # save failed :(
      render :new # show the new work form view again
      return
    end
  end

  def edit
    @work = Work.find_by id: params[:id]
    if @work.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @work = Work.find_by id: params[:id]
    if @work.nil?
      redirect_to root_path
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work
      @work.destroy
      redirect_to root_path
    else
      head :not_found
      return
    end
  end

  def work_params
    return params.require(:work).permit(:title, :description, :publication_date, :category)
  end

end
