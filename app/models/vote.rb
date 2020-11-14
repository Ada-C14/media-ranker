class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # def sum_votes
  #   total_votes = Vote.where(work_id: work_id).count
  #   if total_votes.nil?
  #     return 0
  #   else
  #     return total_votes
  #   end
  # end
end
