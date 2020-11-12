class HomepagesController < ApplicationController
  def index
    # when switching to sort, make sure to set it up so that there is no need to
    # check for total #num of works in spotlight, try .limit(10)
    @spotlight = Work.all.sample
    @books = Work.where(category: 'book').sample(10)
    @movies = Work.where(category: 'movie').sample(10)
    @albums = Work.where(category: 'album').sample(10)
  end
end
