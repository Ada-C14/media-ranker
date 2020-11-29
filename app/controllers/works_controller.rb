class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def homepage
    @works = Work.all
    @top_work = @works.order(vote_count: :desc).first
  end

  def index
    @works = Work.all
  end

  def show
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
    return redirect_to root_path if @work.nil?
  end

  def update
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
        :description,
        :user_ids)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
