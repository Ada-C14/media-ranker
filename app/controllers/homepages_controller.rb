class HomepagesController < ApplicationController

  def index
    @work = Work.all
    @work_first = @work.order(vote_count: :desc).first
    @albums = @work.where(category: "album").order(vote_count: :desc).first(10)
    @books = @work.where(category: "book").order(vote_count: :desc).first(10)
    @movies = @work.where(category: "movie").order(vote_count: :desc).first(10)
  end


end
