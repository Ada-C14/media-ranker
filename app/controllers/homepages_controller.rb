class HomepagesController < ApplicationController
  def index
    @work = Work.all.sample
    @albums = Work.where(category: "album").sample(10)
    @books = Work.where(category: "book").sample(10)
    @movies = Work.where(category: "movie").sample(10)
  end
end
