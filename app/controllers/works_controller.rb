class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
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
      flash[:success] = "#{@work.title.titleize} was successfully created :)"
      redirect_to work_path(@work.id)
      return
    else
      flash.new[:error] = "#{@work.title.titleize} was successfully created :)"
      render :new #, status: :not_found
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
      redirect_to work_path(@work.id)
      return
    else
      render :edit
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id:work_id)

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      redirect_to works_path
    end
  end


  # def upvote
  #   @work = Work.find(params[:id])
  #
  #   if @work.votes.create(user_id: current_user.id)
  #     flash[:notice] =  "Thank you for upvoting!"
  #     redirect_to(works_path)
  #   else
  #     flash[:notice] =  "You have already upvoted this!"
  #     redirect_to(works_path)
  #   end
  # end

  # def vote
  #   @work = Work.find_by(id: params[:id])
  #   if @work.nil?
  #     head :not_found
  #     return
  #   elsif
  #   @work.update(
  #       completed_at: DateTime.now,
  #       )
  #     redirect_to tasks_path
  #     return
  #   end
  # end


  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
