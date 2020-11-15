class HomepagesController < ApplicationController

  skip_before_action :require_login

  def index
    #@works is an array
    @works = Work.all

    @albums = @works.each do |work|
      if work[0] == "album"
        @albums += work
      end
    end
    @albums = @albums.sample(10)

    @books = @works.each do |work|
      if work[0] == "book"
        @books += work
      end
    end
    @books = @books.sample(10)

    @spotlights = @works.sample(10)
  end
end
