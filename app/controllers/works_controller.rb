class WorksController < ApplicationController
  def index
    @works = Work.all
    @ranked_works = rank(@works)
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path, status: :temporary_redirect
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "#{@work.title} was successfully added!"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: could not create #{@work.category}"
      render :new, status: :bad_request
      return
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
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}!"
      redirect_back(fallback_location: root_path)
      return
    else # save failed :(
      flash.now[:error] = "A problem occurred: could not update #{@work.category}"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "A problem occurred: could not update #{@work.category}"
      redirect_to works_path, head: :temporary_redirect
      return
    end


    @work.destroy

    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}!"
    redirect_to works_path
    return
  end

  def homepage
    @works = Work.all

    @spotlight = rank(@works).first

    @books = Work.where(category: "book")
    @ranked_books = rank10(@books)

    @albums = Work.where(category: "album")
    @ranked_albums = rank10(@albums)

    @movies = Work.where(category: "movie")
    @ranked_movies = rank10(@movies)
  end

  def rank10(work_list)
    sorted_list = work_list.sort_by { |work| work.votes.count }.reverse

    return sorted_list.first(10)

  end

  def rank(work_list)
    sorted_list = work_list.sort_by { |work| work.votes.count }.reverse

    return sorted_list
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
