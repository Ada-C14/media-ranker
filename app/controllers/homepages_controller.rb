class HomepagesController < ApplicationController
  def index
    @works = Work.all

    # @albums = Work.where {|w| w.category == "album" }
    @albums = Work.where({category: "album"}).sort_by { |w| -w.votes.count }.take(10)
    @movies = Work.where({category: "movie"}).sort_by { |w| -w.votes.count }.take(10)
    @books = Work.where({category: "book"}).sort_by { |w| -w.votes.count }.take(10)
    # SELECT * FROM users WHERE name = 'Joe' AND email = 'joe@example.com'

    @spotlight = Work.spotlight
    end
end
