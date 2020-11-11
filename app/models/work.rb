class Work < ApplicationRecord

  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true

  # relationship
  has_many :votes
  has_many :users, through: :votes

  def spotlight
    # votes_count column created
    return spotlight_media = Work.order("votes_count DESC")

  end

  def top_ten(category)
    # top ten sort_by vote?
    top_ten_list = Work.where(category: category).sort_by{|work| [work.votes_count, work.title]}.limit(10)
    return top_ten_list
  end
end
