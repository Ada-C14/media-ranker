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
  end

  def create
  end

  private
  def work_params
      return params.require(:work).permit(:name, :title, :creator, :publication_year, :description)
  end

end
