class HomepagesController < ApplicationController
  
  def index
    @works = Work.all
    @media_spotlight = Work.all.sample(1)
    @top_10_movies = Work.where(category: 'movie').sample(10)
    @top_10_books = Work.where(category: 'book').sample(10)
    @top_10_albums = Work.where(category: 'album').sample(10)
  end

end
