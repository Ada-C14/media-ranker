class Work < ApplicationRecord
  validates :category, inclusion: { in: %w(album book movie)}
  validates :title, presence: true, uniqueness: true
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true

  has_many :votes
  has_many :users, through: :votes

  def self.top_ten
    @top_albums = Work.where(category: "album").sample(10)
    @top_books = Work.where(category: "book").sample(10)
    @top_movies = Work.where(category: "movie").sample(10)

    tops = {
        albums: @top_albums,
        books: @top_books,
        movies: @top_movies
    }

    return tops
    # this will be replaced with the top ten vote getters
    # in each category
    # once votes are things that exist
  end

  def self.spotlight
    works = Work.all
    @spotlight = works.sample
    # this will be replaced with the top vote getter
    # once votes are things that exist
  end

  def upvote(user_id)
    @work = self
    @user = User.find_by(id: user_id)
    if @user.nil?
      flash[:error] = "Please log in to vote"
      redirect_to work_path(@work) and return
    end

    @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    return @vote
  end
end
