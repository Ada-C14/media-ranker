class WorksController < ApplicationController
  before_action :find_work, only: [:edit, :update]

  def homepage
    @works = Work.all
    @albums = @works.where(category: 'album')
    @sample_albums = @albums.sample(10)

    @books = @works.where(category: 'book')
    @sample_books = @books.sample(10)

    @movies = @works.where(category: 'movie')
    @sample_movies = @movies.sample(10)

  end

  def index
    @works = Work.all
    @albums = @works.where(category: 'album')
    @books = @works.where(category: 'book')
    @movies = @works.where(category: 'movie')
  end

  def new
    @works = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save #istrue save returns true if the database insert succeeds
      redirect_to work_path(@work.id) and return
    else # if save fails
      render :new, status: :bad_request and return #shows new  form again
    end
  end

  def show
    id = params[:id]
    @work = Work.find_by(id: id)

    if @work.nil?
      redirect_to works_path and return
    end
  end

  def edit
    # @work = Work.find_by(id: params[:id])
    #
    # if @work.nil?
    #   redirect_to works_path
    #   return
    # end
  end


    def update
      if @work && @work.update(work_params)
        flash[:success] = "Succesfully edited #{@work.category} \"#{@work.title}!\""
        redirect_to work_path(@work.id)
      elsif @work
        flash[:error] = "Work edits not saved!"
        @work.errors.messages.each do |field, messages|
          flash[field] = messages
        end
        render :edit
      end
    end



  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work
      @work.destroy
      redirect_to works_path #not sure where to redirect if work was deleted
      return
    else
      head :not_found
      return
    end
  end

  private
  def find_work
    @work = Work.find_by(id: params[:id].to_i)
    if @work.nil?
      flash.now[:warning] = 'Cannot find the work'
      render :notfound, status: :not_found
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
