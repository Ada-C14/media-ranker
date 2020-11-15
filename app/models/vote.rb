class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  # validates :work_id, uniqueness: true

  def self.votes_by_user(user)
    vote_list = Vote.find_by(user_id: user).votes

    return vote_list.includes(:user).order("users.name")
  end


end
