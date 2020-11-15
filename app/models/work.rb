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

  def self.top_ten(category)
    return Work.where(category: category).order(votes_count: :desc, created_at: :asc).first(10)
  end

  def self.spotlight
    return nil if Work.all.empty?

    if Vote.all.empty?
      @spotlight = Work.order(:created_at).first
    else
      @spotlight = Work.order(votes_count: :desc, created_at: :asc).first
    end

    return @spotlight
  end
end
