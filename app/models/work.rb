class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: {scope: :category, case_sensitive: false},
            length: {maximum: 40}
  validates :category, presence: true, inclusion: {in: VALID_CATEGORIES,
                                                   message: "%{value} is not a valid category"}
  validates :creator, presence: true, length: {maximum: 30}
  validates :publication, presence: true,
            numericality: {only_integer: true,
                           less_than_or_equal_to: Date.today.year,
                           greater_than_or_equal_to: 1000}
  validates :description, length: {maximum: 140}

  def self.sort(array_of_works)
    array_of_works.sort! { |work, next_work|
      [next_work.number_of_votes,
       next_work.most_recent_vote_time,
       work.title,
       work.category
      ] <=>
        [work.number_of_votes,
         work.most_recent_vote_time,
         next_work.title,
         next_work.category
        ]
    }
    return array_of_works
  end

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
