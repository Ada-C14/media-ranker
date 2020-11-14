class HomepagesController < ApplicationController
  def index
    @works_hash = {}
    Work.categories.each do |category|
      @works_hash[category] = Work.top_ten(category)
    end

    @media_spotlight = Work.media_spotlight
  end
end
