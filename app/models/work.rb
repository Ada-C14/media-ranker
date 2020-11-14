class Work < ApplicationRecord
  has_many :votes
  validates :category, presence: true, inclusion: { within: %w[movie book album] }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def sum_votes
    return "🤯" if Vote.all.empty?
    work_id = self.id
    total_votes = Vote.where(work_id: work_id).count
    if total_votes.nil?
      return 0
    else
      return total_votes
    end
  end

  def self.spotlight
    return "😬" if Vote.all.empty?
    votes = Vote.all
    vote_count = {}
    count = 0
    votes.each do |vote|
      if vote_count[vote.work_id]
        vote_count[vote.work_id] += 1
      else
        vote_count[vote.work_id] = 1
      end
    end
    return vote_count.key(vote_count.values.max)
  end

  def self.top_ten_sort(category)
    return "🤔" if Work.all.empty?
    works = Work.where(category: category).max_by(10) do |work|
      work.votes.count
    end
  end
end
