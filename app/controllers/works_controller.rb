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
      flash.now[:error] = "Something went wrong. Failed to save work"
      render :new, status: :bad_request
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "Couldn't find work to update."
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Work ID #{@work.id} updated successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Work failed to update"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:error] = "Couldn't find work to delete"
      head :not_found
      return
    elsif @work.destroy
      flash[:success] = "Work deleted successfully"
      redirect_to works_path
      return
    else
      flash[:error] = "Work could not be deleted"
      redirect_to works_path, status: :internal_server_error
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :publication_year,
                                        :category, :description)
  end
end
