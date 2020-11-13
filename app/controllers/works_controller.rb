class WorksController < ApplicationController

  before_action :find_work, except: [:index, :create, :new]

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.create(work_params)
    action_success_check(@work, work_path(@work), destination_view: :new, success_msg: "Successfully created #{@work.category} #{@work.id}")
  end

  def show
    redirect_to works_path and return if @work.nil?
  end

  def edit
    redirect_to works_path and return if @work.nil?
  end

  def update
    redirect_to works_path and return if @work.nil?
    action_success_check(@work.update(work_params), work_path, destination_view: :edit, success_msg: "Successfully updated #{@work.category} #{@work.id}")
  end

  def destroy
    redirect_to works_path and return if @work.nil?

    action_success_check(@work.destroy, works_path, success_msg: "Successfully destroyed #{@work.category} #{@work.id}")
  end

  def upvote
    redirect_to works_path and return if @work.nil?

    if @current_user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to request.referrer and return
    end

    action_success_check(Vote.create(user: @current_user, work: @work), works_path, success_msg: "Successfully upvoted!")
  end

  private

  def work_params
    return params.require(:work).permit(:work_id, :title, :description, :publication_date, :creator, :category)
  end

  def find_work
    @work = Work.find_by(id: params[:id].to_i)
  end

end
