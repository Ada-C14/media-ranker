class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :title, presence: true, uniqueness: {scope: :category, message: 'This work was already added'}

  def self.top(category)
    works = Work.all.where(category:category)
    return works.max_by(10) {|work| work.votes.count}
  end

  def self.spotlight
    return Work.all.max_by {|work| work.votes.count}
  end

end
