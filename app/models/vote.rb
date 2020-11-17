class Vote < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :work, counter_cache: true

  validates :work_id, presence: true
  validates :user_id, presence: true, uniqueness: {scope: :work_id, message: "You may only vote once"}

end
