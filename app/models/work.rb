class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :category, presence: true, inclusion: { within: %w[movie book album] }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def sum_votes
    return 0 if Vote.all.empty?
    return 0 if Work.all.empty?
    work_id = self.id
    total_votes = Vote.where(work_id: work_id).count
    if total_votes.nil?
      return 0
    else
      return total_votes
    end
  end

  def self.spotlight
    return nil if self.all.empty?
    votes = Vote.all
    return self.first.id if votes.length == 0
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

  def self.top_works(category, num = 10)
    return nil if self.all.empty?
    # returns array of works, sorted by highest votes, in descending order (high to low)
    return Work.where(category: category).max_by(num) do |work|
      work.votes.length
    end
  end
end
