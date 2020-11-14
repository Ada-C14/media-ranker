class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :category, presence: true
  validates :title, presence: true
  validates :publication_date, numericality: { only_integer: true, greater_than: 0,  less_than_or_equal_to: 2100}, allow_nil: true
  def self.top_ten(category)
    return Work.all.where(category: category).sort_by{|work| work.title}.max_by(10){|work| work.votes.count}
  end

  def self.top_one
    return Work.all.sort_by{|work| work.title}.max_by{|work| work.votes.count}
  end

end
