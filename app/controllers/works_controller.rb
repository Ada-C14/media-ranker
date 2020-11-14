class WorksController < ApplicationController

  def index
    @albums = Work.all.where(category: "album")
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      content_not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      return
    else
      flash[:error] = "A problem occured: Could not create #{@work.category}"
      bulk_error_message = @work.errors.messages[:title][0]
      flash[:error_message] = "title: #{bulk_error_message}"
      redirect_back(fallback_location: root_path)
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      content_not_found
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      content_not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work
      @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
    end
    redirect_to root_path
     
  end

  def upvote

    user_id = session[:user_id]

    if user_id.nil?
      redirect_back(fallback_location: root_path)
      flash[:error] = "A problem occurred: You must log in to do that"
    else
      vote = Vote.new(user_id: user_id, work_id: params[:id])
      if vote.save
        redirect_back(fallback_location: root_path)
        flash[:success] = "Successfully upvoted!"
      else
          # TODO: you also cant vote for something twice...
        redirect_back(fallback_location: root_path)
        flash[:error] = "A problem occurred: Could not upvote"
        raise
        # this is the wrong error message...
        bulk_error_message = vote.errors.messages[:user_id][0]
        flash[:error_message] = "user: #{bulk_error_message}"
        # maybe below will capture error message from validation
        # raise
        # flash[:error_message] = 
      end
    end
  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
