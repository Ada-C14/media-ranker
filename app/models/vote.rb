class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :work
    # Can not vote for the same work more than 1
    validates :user_id, presence: true, uniqueness: { scope: :work_id }
end
