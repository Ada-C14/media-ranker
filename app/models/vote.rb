class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work_id, uniqueness: {scope: :user_id}

  # def voted?
  #   self.work.votes.each do |vote|
  #     return true if vote.user_id == self.user.id
  #   end
  #   return false
  # end
end
