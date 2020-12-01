class Vote < ApplicationRecord
    belongs_to :user, counter_cache: :vote_count
    belongs_to :work, counter_cache: :vote_count

    validates :user, uniqueness: {scope: :work, message: "You have already voted for this work"}
end
