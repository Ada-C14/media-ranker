class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: {scope: :category}

  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  def self.top_work
    return nil if Work.nil?

    top_work = Work.all.max_by { |work| work.votes.count }
    return top_work
  end

  def self.top_ten(media)
    # sort_by sorts smallest to largest
    # but this actually returns an empty array when a category is empty
    return nil if self.nil?

    works = Work.where(category: media)
    sorted = works.sort_by { |work| [-work.votes.count, work.title] }[0..9]

    return sorted
  end

end
