class WorksController < ApplicationController
  def homepage
    @works = Work.all
    @sample_work = @works.sample
  end

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    return :not_found if @work.nil?
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "#{@work.title} was successfully added!"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "#{@work.title} was not successfully added!"
      render :new, status: :bad_request
      return
    end

  end

  def edit
    @work = Work.find_by(id: params[:id])
    return redirect_to root_path if @work.nil?
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      redirect_to root_path
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      flash[:success] = "#{@work.title} was successfully deleted!"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(
        :category,
        :title,
        :creator,
        :publication_year,
        :description)
  end
end
