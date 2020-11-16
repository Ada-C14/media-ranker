class WorksController < ApplicationController
  before_action :find_work, only: [:destroy, :show, :edit, :update]

  def index
    @work = Work.all
    @movies = @work.where(category: "movie")
    @books = @work.where(category: "book")
    @albums = @work.where(category: "album")
    @movies = top(@movies.size, @movies)
    @books = top(@books.size, @books)
    @albums = top(@albums.size, @albums)
  end

  def show
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      render :new
      return
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to homepage_path
      return
    end
  end


  def top(number=10, media)
    number = number.to_i
    return media.max_by(number) { |work| work.votes.count }
  end

  # def most_votes
  #   most_votes =
  #   #If works has greatest amount of votes
  #   # return that work
  #   # and votes
  #   return most_votes
  # end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
    return @work
  end
end
