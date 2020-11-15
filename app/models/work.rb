class Work < ApplicationRecord
  has_many :users, through: :votes
  has_many :votes

  validates :category, presence: true
  validates :title, :creator, :description, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year.to_i }


  def self.spotlight
    works = Work.all.max_by { |work| work.votes.count}
  end

  def self.top_ten(category)
    works = Work.all.where(category: category)
    return works.max_by(10) { |work| work.votes.count}
  end


end
