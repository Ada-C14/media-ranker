class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category }

  def self.spotlight
    return spotlight_media = Work.order(votes_count: :desc).first
  end

  def self.top_ten(category)
    return nil if (Work.all).empty?
    top_ten_list = Work.where(category: category).order(votes_count: :desc, title: :asc).first(10)
    return top_ten_list
  end

  def self.sorted_media(category)
    return nil if (Work.all).empty?
    sorted_collection = Work.where(category: category).sort_by { |work| [work.votes_count, work.title] }
    return sorted_collection
  end
end

# def upvote(user)
#     # create a work from user through this work
#     vote = Vote.new(user: user, work: self)
#     vote.save
# end

# def self.find_by_category(category)
#     Work.where(category: :category).left_joins(:votes).group(:id).order("COUNT(votes) DESC, TITILE ASC")
# end
