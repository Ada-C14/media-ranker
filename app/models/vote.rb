class Vote < ApplicationRecord
  validates :user_id, uniqueness: {scope: :work_id, message: "has already voted for this work"}

  belongs_to :work, counter_cache: true

  belongs_to :user


  def self.connect_work_user(work_id, user_id)
    return Vote.new(work_id: work_id, user_id: user_id)
  end

  def date
    return self.created_at.strftime("%b %d, %Y")
  end
end

