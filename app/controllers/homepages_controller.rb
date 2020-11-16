class HomepagesController < ApplicationController


  def index
     @work = Work.all
     @movies = @work.where(category: "movie")
      @books = @work.where(category: "book")
     @albums = @work.where(category: "album")
     @spotlight = spotlight

  end


  def spotlight
    @works = Work.all
    most_votes = Work.new
    @works.each do |work|
      if work.votes.size > most_votes.votes.size
        most_votes = work
      end
    end
    return most_votes
  end
  end