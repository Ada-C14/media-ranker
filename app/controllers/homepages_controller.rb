class HomepagesController < ApplicationController
  def home
    @albums = Work.top_ten(:album)
    @books = Work.top_ten(:book)
    @movies = Work.top_ten(:movie)
    @media_spotlight = Work.media_spotlight
  end
end
