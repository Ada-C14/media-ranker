class WorksController < ApplicationController
  def index
    @works = Work.all
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")

    @top_books = Work.find_top_books
    @top_albums = Work.find_top_ten_albums
    @top_movies = Work.find_top_movies
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    end
  end
end
