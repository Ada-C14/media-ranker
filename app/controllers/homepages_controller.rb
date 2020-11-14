class HomepagesController < ApplicationController

  def index
    @works = Work.all
    @votes = Vote.all
    @work = Work.find_by(id: params[:id])
    @media_spotlight = Work.find_by(id: Work.spotlight)
    @top_movies = Work.top_works('movie')
    @top_books = if Work.where(category: 'book').length <= 10
                   Work.where(category: 'book')
                 else
                   Work.where(category: 'book').sample(10)
                 end
    @top_albums = if Work.where(category: 'album').length <= 10
                    Work.where(category: 'album')
                  else
                    Work.where(category: 'album').sample(10)
                  end

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
