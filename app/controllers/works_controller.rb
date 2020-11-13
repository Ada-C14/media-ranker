class WorksController < ApplicationController

  def index
    # Hash is category => array of category objects
    @works_hash = {}
    Work.categories.each do |category|
      @works_hash[category] = Work.where(category: category)
    end

  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Work added successfully with ID #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash[:error] = "Something went wrong. Failed to save work"
      render :new, status: :bad_request
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year,
                                        :category, :description)
  end
end
