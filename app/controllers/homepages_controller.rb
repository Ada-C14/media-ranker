class HomepagesController < ApplicationController
  def index
    # when switching to sort, make sure to set it up so that there is no need to
    # check for total #num of works in spotlight, try .limit(10)
    @spotlight = Work.all.max_by{|work| work.votes.count}
    @books = Work.where(category: 'book').sort_by{|work| -work.votes.count}.first(10)
    @movies = Work.where(category: 'movie').sort_by{|work| -work.votes.count}.first(10)
    @albums = Work.where(category: 'album').sort_by{|work| -work.votes.count}.first(10)
  end
end
