class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
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



end
