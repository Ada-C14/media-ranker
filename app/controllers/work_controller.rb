class WorkController < ApplicationController
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
  end

  def edit
  end

  def destroy
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
      return params.require(:work).permit(:name, :title, :creator, :publication_year, :description)
  end

end
