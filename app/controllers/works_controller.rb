class WorksController < ApplicationController

  def index
    @books = Work.where(category: 'book').sort_by { |x| -x.votes.count}
    @albums = Work.where(category: 'album').sort_by { |x| -x.votes.count}
    @movies = Work.where(category: 'movie').sort_by { |x| -x.votes.count}
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    #instantiate a new book
    if @work.save
      redirect_to work_path(@work.id)
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      return
    else # save failed :(
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    elsif @work.update(work_params)
      redirect_to works_path # go to the index so we can see the work in the list
      return
    else # save failed :(
      flash.now[:error] = "A problem occurred: Could not edit #{@work.category}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

    @work.destroy

    redirect_to works_path
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
