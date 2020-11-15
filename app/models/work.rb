class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: { scope: [:category] }

  has_many :votes

  def self.top_10(category)

    # works by category
    works_by_category = self.where(category: category)
    # top 10 order by number of votes
    # ties? alphabetical order by title
    # if all 0 votes, none will be listed
    return works_by_category.sort_by { |x| [-x.votes.count, x.title]}.first(10)

  end

  #for now, the spotlight is based on the oldist publication year
  def self.spotlight
    works = self.all.filter {|work| !(work.publication_year.nil?)}
    return works.min_by { |work| work.publication_year}
  end

  def upvote(current_user_id)
    # user is the current session
    user = User.find_by(id: current_user_id)
    return Vote.new(user: user, work: self)
  end

end
