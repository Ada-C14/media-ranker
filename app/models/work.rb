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

  def vote_button(current_user)
    if current_user.class == User
      vote = self.votes.find_by(user_id: current_user.id)
      if vote.nil?
        return "Vote!"
      else
        return "Remove Vote"
      end
    else
      return nil # will return flash warning
    end
  end

  def most_recent_vote_time
    most_recent_vote_time = self.votes.reduce(0) do |most_recent_vote_time, vote|
      vote.created_at > most_recent_vote_time ? vote.created_at : most_recent_vote_time
    end

    if most_recent_vote_time == 0
      most_recent_vote_time = Time.new(0)
    end
    return most_recent_vote_time
  end

  def number_of_votes
    self.votes.size
  end

  def print_number_of_votes
    if self.votes.size != 1
      return "#{self.votes.size} votes"
    else
      return "#{self.votes.size} vote"
    end
  end

  def self.top_ten(sorted_hash)
    top_ten_works = Hash.new
    sorted_hash.each do |category, works|
      unless works == []
        works = works[0..9]
        works.delete_if { |work| work.number_of_votes < 1 }
      end
      top_ten_works[category] = works
    end
    return top_ten_works
  end

  def self.spotlight(sorted_hash)
    if Vote.none?
      # flash.now[:warning] = "There aren't works with votes, yet. Start voting!"
      return Work.all.sample(10)
    else
      top_works = []
      sorted_hash.each do |category, works|
        unless works.first.nil?
          top_works << works.first
        end
      end
      return Work.sort(top_works).first
    end
  end
end
