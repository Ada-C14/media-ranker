class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category }
  validates :category, presence: true

  def self.spotlight
    # return Work.all.sample # before adding votes model
    return Work.all.max_by { |work| work.votes.count}
  end

  def self.top_ten(category)
    # return Work.where(category: category).sample(10) # before adding votes model
    return Work.where(category: category).sort_by { |work| work.votes.count }.reverse[0..9]
  end
end
