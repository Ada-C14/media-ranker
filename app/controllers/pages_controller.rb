class PagesController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.select{ |work| work.category == 'album'}
    @books = Work.select { |work| work.category == "book" }
    @movies = Work.select{ |work| work.category == 'movie'}
  end
end


