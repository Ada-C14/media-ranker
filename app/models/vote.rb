class Vote < ApplicationRecord

  belongs_to :work, counter_cache: :vote_count
  belongs_to :user

  validates :work_id, :presence => true
  validates :user_id, :presence => true

  validates_uniqueness_of :user_id, :scope => :work_id, :message => 'user: has already voted for this work'


end
