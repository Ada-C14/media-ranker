class Vote < ApplicationRecord
  validates :work_id, uniqueness: {scope: :user_id}

  belongs_to :work
  belongs_to :user

  def self.connect_work_user(work_id, user_id)
    return Vote.new(work_id: work_id, user_id: user_id)
  end
end

