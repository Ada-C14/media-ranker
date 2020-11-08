class HomepagesController < ApplicationController
  def index
    @works = Work.sample(10)
  end
end
