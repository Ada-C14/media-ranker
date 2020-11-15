class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :works, through: :votes

  validates :username,
            presence: true,
            uniqueness: true

  def includes_work?(work_id)
    works = self.works

    works.each do |work|
      return true if work.id == work_id.to_i
    end

    return false
  end

  def self.sort_users
    # User.all.sort_by { |user| [user.votes.count, user.created_at] }.reverse
    User.order('votes_count DESC, created_at')
  end
end
