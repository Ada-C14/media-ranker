class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    @work_id = params[:id].to.i
    @works = Work.find_by(id:@work_id)

    if @works.nil?
      head :not_found
      return
    end

  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    successful_save = @work.save

    if successful_save
      redirect_to work_path(@work.id)
      return
    else
      render :new, status :not_found
    end
  end

  def edit
    redirect_to work_path if @work.nil?
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit
      return
    end
  end

private

def work_params
  params.require(:work).permit( :media, :title, :created_by, :published, :description)
end


# elsif @work.update(media:params[:work][:media], title: params[:work][:title],created_by: params[:work][:created_by], published: params[:work][:published], description:[:work][:description])