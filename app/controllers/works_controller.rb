class WorksController < ApplicationController

  def index
    @albums = Work.all.where(category: "album")
    @books = Work.all.where(category: "book")
    @movies = Work.all.where(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])

    # TODO:
    # if @work.nil?
    #   # here need to redirect to an error page
    # end
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
      # TO DO: check to make sure this shows correctly in view (along with validation error message)
      flash.now[:error] = "A problem occured: Could not create #{@work.category}"
      render :new # show the create form again
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    # TODO:
    # if @work.nil?
    #   # here need to redirect to an error page
    # end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      # TODO:
      # here need to redirect to an error page
      # return
      puts "redirect to that same error page as above"
    elsif @work.update(work_params)
      # TO DO: also need to have that successfully updated thing pop up
      redirect_to work_path(@work.id)
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work
      # TO DO: also need to have that successfully updated thing pop up
      @work.destroy
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
        # maybe below will capture error message from validation
        # flash[:error_message] = 
      end
    end
  end


  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
