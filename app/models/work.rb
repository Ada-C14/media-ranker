class Work < ApplicationRecord
  validates :category, inclusion: { in: %w(album book movie)}
  validates :title, presence: true, uniqueness: true
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true

  has_many :votes
  has_many :users, through: :votes

  def users
    users = []
    votes.each do |vote|
      users << vote.user
    end

    return users
  end

  def self.top_ten
    # array of the three category words
    # each through the array
    # for each category
    # find the top ten for that category
    # (what if the ten-cut off point comes in the middle of a range of
    # same number votes?)
    # like if nine, ten, and eleven all have one vote
    # which one gets left out?
    # (by spotlight logic, that would be the one added to the db most recently)
    # how applicable is that?
    #
    @top_albums = Work.where(category: "album").sample(10)
    @top_books = Work.where(category: "book").sample(10)
    @top_movies = Work.where(category: "movie").sample(10)


    chart_toppers = {
        albums: @top_albums,
        books: @top_books,
        movies: @top_movies
    }

    return chart_toppers
    # TODO this will be replaced with the top ten vote getters
    # in each category
    # once votes are things that exist
  end

  def self.spotlight
    return nil if Work.all.empty?
    if Vote.all.empty?
      @spotlight = Work.order(:created_at).first
    end

    # sort works by # of votes - what's highest #?
    # find all works with that # of votes
    # if one, return it
    # if more than one, sort by earliest created_at
    # return that one
    #
    # alternatively, look into adding a cache counter
    # that feels more...programmy, pro-level

    # this is the original placeholder method
    # works = Work.all
    # @spotlight = works.sample
    # TODO this will be replaced with the top vote getter
    # once votes are things that exist
  end
end
