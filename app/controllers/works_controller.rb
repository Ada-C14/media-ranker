class WorksController < ApplicationController

  def index
    @work = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def work_params
    return params.require(:work).permit(:title, :author, :publish_date,:category, :description, :votes)
  end

end
