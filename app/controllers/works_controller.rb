class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def homepage
    @top_work = Work.top_work

    @albums_top_ten = Work.top_ten('album')
    @books_top_ten = Work.top_ten('book')
    @movies_top_ten = Work.top_ten('movie')
  end

  def index
    @albums = Work.where(category: 'album')
    @books = Work.where(category: 'book')
    @movies = Work.where(category: 'movie')
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save #is true
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id) and return
    else
      flash_model_errors(@work, "Could not create #{@work.category}")
       # errors is an object, where .messages is example: @messages={:title=>["can't be blank"]}
      render :new, status: :bad_request and return
    end
  end

  def show; end

  def edit; end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work) and return
    else
      flash_model_errors(@work, "Could not update #{@work.category}")
      render :edit, status: :bad_request
    end
  end

  def destroy
    if @work
      flash[:success] = "Successfully deleted #{@work.category} #{@work.id}"
      @work.destroy
      redirect_to root_path and return
    else #if destroy fails
      flash[:error] = ["Failed to destory work"]
      redirect_to works_path and return
    end
  end

  private

  def find_work
    id = params[:id]
    @work = Work.find_by(id: id)

    if @work.nil?
      flash[:error] = ["Work with ID:#{id} could not be found."]
      redirect_to works_path and return
    end
  end

  # def format_errors
  #   formatted = errors.map do |attribute, message|
  #     "#{attribute.capitalize.to_s.gsub("_id", "")}: #{message}"
  #   end
  #
  #   return formatted
  # end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication, :description)
  end
end
