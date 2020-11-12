class HomepagesController < ApplicationController
  def index
    @CATEGORIES = ['album', 'movie', 'book']
    @works_hash = {}
    @CATEGORIES.each do |category|
      @works_hash[category] = Work.top_ten(category)
    end

    @media_spotlight = Work.media_spotlight
  end
end
