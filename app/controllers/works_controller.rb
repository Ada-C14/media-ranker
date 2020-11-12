class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "#{@work.category} added successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}."
      render :new, status: :bad_request
      return
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
    elsif  @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      head :not_found
      return
    end
    @work.destroy
    redirect_to works_path
    return
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :publication_date, :creator, :category)
  end
end
