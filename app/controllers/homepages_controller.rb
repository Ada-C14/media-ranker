class HomepagesController < ApplicationController

  def index
     @work = Work.all
     @movies = @work.where(category: "movie")
     @books = @work.where(category: "book")
     @albums = @work.where(category: "album")
  end

end
