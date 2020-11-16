class WorksController < ApplicationController

  before_action :require_login, only: [:new, :create, :update, :edit, :destroy]

  def homepage
    @works = Work.all
  end

  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash.now[:error] = "Hmm..we couldn't find a work with that id"
      redirect_to root_path #for now.. flash?
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "You've successfully created a new work!"
      redirect_to work_path(id: @work[:id])
      return
    else
      flash.now[:error] = "Hmm..something went wrong, your work was not saved"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash.now[:error] = "Hmm..we couldn't find a work with that id"
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash.now[:error] = "Hmm..we couldn't find a work with that id"
      render :not_found
      return
    else
      @work.update(work_params)
      flash[:success] = "You've successfully edited this work!"
      redirect_to work_path(id: @work[:id])
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash.now[:error] = "Hmm..we couldn't find a work with that id"
      redirect_to works_path
      return
    else
      @work.destroy
      flash[:success] = "You've successfully deleted this work! Who needs it!"
      redirect_to works_path
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
