class HomepagesController < ApplicationController
  def index
    @works_book = Work.where(category: 'book').sample(10)
    @works_album = Work.where(category: 'album').sample(10)
    @works_movie = Work.where(category: 'movie').sample(10)
  end
end
