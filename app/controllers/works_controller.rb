class WorksController < ApplicationController
  def index
    @works = Work.all

    WORK_CATEGORIES.each do |category|
      var_name = "@#{category}s"
      instance_variable_set(var_name, Work.by_category(category))
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(works_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      flash.now[:validation] = @work.errors.messages
      render :new, status: :bad_request
      return
    end
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      head :not_found
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      head :not_found
      return
    elsif @work.update(works_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
      return
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      flash.now[:validation] = @work.errors.messages
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      head :not_found
      return
    elsif @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to works_path
      return
    else
      flash.now[:error] = "A problem occurred: Could not delete #{@work.category}"
      render :show
      return
    end
  end


  private

  def works_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
