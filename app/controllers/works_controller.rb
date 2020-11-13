class WorksController < ApplicationController
  def home
    @works = Work.all
    @all_works = Work.list_all_works
    @top_ten = Work.top_ten(@all_works)
    @spotlight = Work.spotlight(@top_ten)
  end

  def index
    @works = Work.all
  end

  def new
    @work = Work.new()
  end

  def show
    if @work.nil?
      flash.now[:failure] = "Not found! Try again?"
      redirect_to work_path
    end
  end


  private

  def work_params
    return params.require(:work).permit(
        :category,
        :title,
        :creator,
        :publication_year,
        :description
    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def find_work_votes
    @work_votes = Work.find_by(id: params[:id]).votes
  end
end