class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show

  end

  def new
    @work = Work.new
  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy

  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :description, :publication_year)
  end
end
