class HomepagesController < ApplicationController
  
  def index
    @works = Work.all
    @media_spotlight = Work.all.sample(1)
    @top_10_movies = Work.where(category: 'movie').sample(10)
    @top_10_books = Work.where(category: 'book').sample(10)
    @top_10_albums = Work.where(category: 'album').sample(10)
    # TODO: uncomment for later
    # if Work.where(category: 'movie').length <= 10
    #   @movies = Work.where(category: 'movie')
    # else
    #   # display top 10
    # end
    #
    # if Work.where(category: 'book').length <= 10
    #   @movies = Work.where(category: 'movie')
    # else
    #   # display top 10
    # end
    #
    # if Work.where(category: 'album').length <= 10
    #   @movies = Work.where(category: 'movie')
    # else
    #   # display top 10
    # end
    #
  end

end
