class WorksController < ApplicationController
  def index
    # Hoping for future expansion in media categories
    @CATEGORIES = ['album', 'movie', 'book']
    # Hash is category => array of category objects
    @works_hash = {}
    @CATEGORIES.each do |category|
      @works_hash[category] = Work.where(category: category)
    end

  end
end
