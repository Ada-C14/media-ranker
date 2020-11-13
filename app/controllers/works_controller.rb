class WorksController < ApplicationController

  def index
    @work = Work.all
    @albums = @work.where(category: "album")
    @books = @work.where(category: "book")
    @movies = @work.where(category: "movie")
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
      flash[:success] = "#{@work.title} has been added.ㄟ(▔▽▔ㄟ)"
      redirect_to root_path
      return
    else
      flash.now[:error] = "Oops, something went wrong. #{@work.title} not added.ㄟ(▔︹▔ㄟ) "
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "#{@work.title} has been updated. ㄟ(▔▽▔ㄟ)"
      redirect_to works_path
      return
    else
      flash.now[:error] = "Something went wrong. #{@work.title} not updated. ㄟ(▔︹▔ㄟ)"
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end

    @work.destroy
    redirect_to works_path
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :votes)
  end

end
