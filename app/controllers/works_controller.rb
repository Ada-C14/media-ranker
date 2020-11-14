class WorksController < ApplicationController

  def index
    @works = Work.all
    @movies = Work.where(category: 'movie')
    @books = Work.where(category: 'book')
    @albums = Work.where(category: 'album')
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
    result = @work.save
    if result
      if @work.category == 'movie'
        flash[:success] = "The movie #{@work.title} was added! 🍿"
      elsif @work.category == 'book'
        flash[:success] = "The book #{@work.title} was added! 📖"
      elsif @work.category == 'album'
        flash[:success] = "The album #{@work.title} was added! 👩‍🎤"
      end
      redirect_to work_path(@work.id)
      return
    else
      flash[:error] = "Unable to add media!"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
    elsif @work.update(work_params)
      flash[:success] = "Success! The #{@work.category} #{@work.title} has been updated."
      redirect_to work_path(params[:id])
      return
    else
      flash.now[:error] = "Unable to perform update!"
      render :edit
      return
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
      return
    end

    work.destroy
    flash[:success] = "🔥The #{work.category} #{work.title} has been removed🔥"
    redirect_to root_path
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
