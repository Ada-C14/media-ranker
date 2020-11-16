class HomepagesController < ApplicationController


  def index
     @work = Work.all
     @movies = @work.where(category: "movie")
      @books = @work.where(category: "book")
     @albums = @work.where(category: "album")
     @spotlight = spotlight
     @top_books = top( @books)
     @top_movies = top(@movies)
     @top_albums = top(@albums)

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

  def top(number=10, media)
    number = number.to_i
    return media.max_by(number) { |work| work.votes.count }
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