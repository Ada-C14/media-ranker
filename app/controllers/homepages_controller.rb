class HomepagesController < ApplicationController

  def index
    @works = Work.all
    @votes = Vote.all
    @work = Work.find_by(id: params[:id])
    @media_spotlight = Work.find_by(id: Work.spotlight)
    @top_movies = Work.top_works('movie')
    @top_books = Work.top_works('book')
    @top_albums = Work.top_works('album')
  end

end
