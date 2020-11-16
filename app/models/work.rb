class Work < ApplicationRecord
  has_many :votes


  VALID_CATEGORIES = ['album', 'book', 'movie']

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category, presence: true, inclusion: {in: VALID_CATEGORIES}

  def self.top_by_category(category, count:10)
    if !VALID_CATEGORIES.include?(category)
      raise ArgumentError("Invalid category")
    end
    list = Work.where(category: category)

    # top =
    top = Work.where(category: category)
              .left_joins(:votes)
              .group(:id)
              .order('COUNT(votes.id) DESC')
              .limit(10)
    return top
  end

  def self.spotlight
    list = Work.all
    spotlight = list.max_by{|work| work.votes.count}
    return spotlight
  end
end
