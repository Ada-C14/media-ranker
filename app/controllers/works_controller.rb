class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      # Change this to a 404 page
      redirect_to works_path
    end
  end

  private

  # Strong Params: https://learn-2.galvanize.com/cohorts/2036/blocks/1006/content_files/intro-to-rails/strong-params.md

end
