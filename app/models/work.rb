class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  def self.top_ten(category)
    return Work.all.where(category: category).max_by(10){|work| work.votes.count}
  end

  def self.top_one
    return Work.all.max_by{|work| work.votes.count}
  end


end
