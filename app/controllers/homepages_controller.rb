class HomepagesController < ApplicationController
  def index
    @spotlight = Work.spotlight
  end
end
