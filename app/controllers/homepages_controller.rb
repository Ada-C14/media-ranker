class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @spotlight = Work.spotlight
  end
end
