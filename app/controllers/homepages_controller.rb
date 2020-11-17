class HomepagesController < ApplicationController


  def index
     @work = Work.all
     @movies = @work.where(category: "movie")
      @books = @work.where(category: "book")
     @albums = @work.where(category: "album")
     @spotlight = Work.spotlight
     @top_books = Work.top( @books)
     @top_movies = Work.top(@movies)
     @top_albums = Work.top(@albums)

  end



  #
  # def top_ten
  #   @works = Work.all
  #   if @work.where(category: "movie")
  #     return top_ten_helper
  #   end
  # end
  #
  # def top_ten_helper
  #   @works = Work.all
  #   @movies = @work.where(category: "movie")
  #   most_votes = Array.new(10, Work.new)
  #   @movies.each do |movie|
  #     if movie.work.votes.size > most_votes.work.votes.size
  #       most_votes << movie
  #     end
  #   end
  #   return most_votes
  # end



end