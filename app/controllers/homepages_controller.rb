class HomepagesController < ApplicationController
  def index
    # @works = Work.all
    @movies = Work.all.select { |w| w.category == "movie" }
    @books = Work.all.select { |w| w.category == "book" }
    @albums = Work.all.select { |w| w.category == "album" }

    @spotlight = Work.spotlight
    end
end
