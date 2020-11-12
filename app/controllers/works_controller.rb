class WorksController < ApplicationController

  # Helper Methods
  def not_found_error_notice
    flash[:notice] = "That work does not exist."
    redirect_to works_path
  end

  def not_saved_error_notice
    flash[:notice] = "That did not save correctly."
  end

  #########################################################

  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by_id(id: work_id)

    if @work.nil?
      not_found_error_notice
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(
        category: params[:work][:category],
        title: params[:work][:title],
        creator: params[:work][:creator],
        publication_year: params[:work][:publication_year],
        description: params[:work][:description])

    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      not_saved_error_notice
      render :new
      return
    end
  end
end