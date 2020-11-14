class Work < ApplicationRecord
  has_many :votes
  validates :category, presence: true, inclusion: { within: %w[movie book album] }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def sum_votes
    work_id = self.id
    total_votes = Vote.where(work_id: work_id).count
    if total_votes.nil?
      return 0
    else
      return total_votes
    end
  end
end
