class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: { scope: [:category] }

  has_many :votes

  def self.top_10(category)

    # works by category
    works_by_category = self.where(category: category)
    # top 10 order by number of votes
    # ties? alphabetical order by title
    return works_by_category.sort_by { |x| [-x.votes.count, x.title]}.first(10)

  end

  def self.spotlight

    if self.all.empty?
      return nil
    end

    spotlight = self.all.sort_by { |x| [-x.votes.count, x.title]}.first

    if spotlight.votes.count == 0
      return nil
    else
      return spotlight
    end

  end

  def upvote(current_user_id)
    # user is the current session
    user = User.find_by(id: current_user_id)
    return Vote.new(user: user, work: self)
  end

end
