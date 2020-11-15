class WorksController < ApplicationController
  skip_before_action :find_work, except: [:show, :edit, :update, :destroy]

  def home
    @works = Work.all
    @all_works = Work.list_all_works
    @top_ten = Work.top_ten(@all_works)
    @spotlight = Work.spotlight(@top_ten)
  end

  def index
    @works = Work.all
  end

  def new
    @work = Work.new()
  end

  def show
    if @work.nil?
      flash.now[:failure] = "Not found! Try again?"
      redirect_to work_path
    end
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created new #{@work.category} \"#{@work.title}!\""
      redirect_to works_path
    else
      flash[:error] = "Work not created!"
      @work.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      redirect_to new_work_path
    end
  end

  def edit; end

  def update
    if @work && @work.update(work_params)
      flash[:success] = "Succesfully edited #{@work.category} \"#{@work.title}!\""
      redirect_to work_path(@work.id)
    elsif @work
      flash.now[:error] = "Work edits not saved!"
      @work.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      render :edit
    end
  end

  def destroy
    if @work.nil?
      @deleted_work = @work.destroy
      flash[:success] = "#{@work.title} deleted"
      redirect_to root_path
    else
      flash[:failure] = "Work #{@work.title} not destroyed."
      redirect_back fallback_location: root_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(
        :category,
        :title,
        :creator,
        :publication_year,
        :description
    )
  end


  def find_work_votes
    @work_votes = Work.find_by(id: params[:id]).votes
  end
end