class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{ params[:category] } #{ params[:id] }"
      redirect_to work_path(@work)
      return
    else
      # if no title is provided + errors.message on view
      # title is sensitive to up/lowercase, but up/lowercase are two different works. Different category couldn't share the same title.
      flash.now[:error] = "A problem occurred: Could not create #{ params[:category] }"
      render :new, status: :bad_request 
      return
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{ params[:category] } #{ params[:id] }"
      redirect_to work_path(@work.id) 
      return
    else  
      # Plus errors.message on view  
      flash.now[:error] = "A problem occurred: Could not update #{ params[:category] }"  
      render :edit, status: :bad_request 
      return 
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil? 
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end

    @work.destroy
    redirect_to root_path
    return
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
