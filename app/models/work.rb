class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true

  # relationship
  has_many :votes
  has_many :users, through: :votes

  def self.spotlight
     spotlight_media = Work.all.sample
     return spotlight_media
  end

  def self.top_ten(category)
    # top ten sort_by vote?
    top_ten_list = Work.where(category: category).sort_by { |work| [work.votes.count, work.title] }.limit(10)
    return top_ten_list
  end
end
