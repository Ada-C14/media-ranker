class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category, case_sensitive: false },
                    length: { maximum: 40 }
  validates :category, presence: true, inclusion: { in: VALID_CATEGORIES,
                                                    message: "%{value} is not a valid category" }
  validates :creator, presence: true, length: { maximum: 30 }
  validates :publication, presence: true,
                          numericality: { only_integer: true,
                                          less_than_or_equal_to: Date.today.year,
                                          greater_than_or_equal_to: 1000 }
  validates :description, length: { maximum: 140 }

  # for WorksController#home
  def self.list_all_works
    all_works = Hash.new
    VALID_CATEGORIES.each do |category|
      works_by_category = Work.by_category(category)
      all_works[category] = Work.sort(works_by_category)
    end
    return all_works
  end

  def self.by_category(category)
    Work.where(category: category).order(title: :asc).to_a
  end

end
