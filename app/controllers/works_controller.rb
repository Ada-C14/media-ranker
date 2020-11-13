class WorksController < ApplicationController
  def index
    # Planning for future expansion in media categories
    @CATEGORIES = ['album', 'movie', 'book']
    # Hash is category => array of category objects
    @works_hash = {}
    @CATEGORIES.each do |category|
      @works_hash[category] = Work.where(category: category)
    end

  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    end
  end
end
