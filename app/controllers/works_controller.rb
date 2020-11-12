class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash.now[:error] = "Work not found"
      redirect_to works_path and return
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
end
