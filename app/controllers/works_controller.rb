class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end    
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{ @work.category } #{ @work.id }"
      redirect_to work_path(@work)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{ params[:work][:category] }"
      render :new, status: :bad_request 
      return
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{ @work.category } #{ @work.id }"
      redirect_to work_path(@work.id) 
      return
    else  
      flash.now[:error] = "A problem occurred: Could not update #{ @work.category }"  
      render :edit, status: :bad_request 
      return 
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil? 
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end
    
    # To destroy the work and the votes!
    @work.destroy
    @work.votes.destroy_all
    flash[:success] = "Successfully destroyed #{ @work.category } #{ @work.id }"
    redirect_to root_path
    return
  end

  def upvote
    @work = Work.find_by(id: params[:id])
    if @work.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return
    end

    vote = @work.votes.new(user_id: session[:user_id], work_id: @work.id, date: Time.now.strftime("%b %d, %Y"))
    
    if session[:user_id].nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      # Redirect to the original page if upvote is failed.
      redirect_back(fallback_location: root_path)
      return
    elsif vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
      return  
    else
      flash[:error] = "A problem occurred: Could not upvote"
      redirect_back(fallback_location: root_path)
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
