class WorksController < ApplicationController
  def index
    # Hoping for future expansion in media categories
    @CATEGORIES = ['album', 'movie', 'book']
    # Hash is category => array of category objects
    @works_hash = {}
    @CATEGORIES.each do |category|
      @works_hash[category] = Work.where(category: category)
    end

    # if params[:count]
    #   # TODO: Move this to model
    #   @works_hash.each do |category, contents|
    #     @works_hash[category] = @works_hash[category][contents].sample(params[:count])
    #   end
    # end

  end
end
