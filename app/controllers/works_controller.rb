class WorksController < ApplicationController

  def index
    @works = Work.order("votes_count DESC, created_at")
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end

  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work), success: "Successfully created #{@work.category} #{@work.id}"
      return
    else
      flash.now[:error] = "Something happened. Work not added."
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work), success: "Successfully updated #{@work.category} #{@work.id}"
      return
    else # update failed
      flash.now[:error] = "Something happened, Work not updated"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    elsif @work.delete
      redirect_to works_path, success: "Successfully deleted #{@work.category} #{@work.id}"
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
