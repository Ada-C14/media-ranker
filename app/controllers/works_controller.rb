class WorksController < ApplicationController
  def index
    # in controller or model?
    # @works = Work.all.order("votes_count DESC")
    @works = Work.all
    @movies = Work.where(category: "movie")
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash.now[:success] = "Successfully created  #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      flash.now[:error] = "something happend, #{@work.category} not added!"
      render :new, status: :bad_request
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Succesfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      render :edit, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
      return
    else
      work.destroy
      flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
      redirect_to works_path
    end

  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
