class HomepagesController < ApplicationController
  def index
    @spotlight = Work.spotlight
    @work_hash = Work.work_hash
  end
end
