class HomepagesController < ApplicationController
  def index
    @spotlight = Work.first
    @books = Work.where(category: 'book').sample(10)
    @movies = Work.where(category: 'movie').sample(10)
    @albums = Work.where(category: 'album').sample(10)
  end
end
