class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work, counter_cache: true #https://blog.appsignal.com/2018/06/19/activerecords-counter-cache.html

  validates :user, uniqueness: { scope: :work, message: "has already voted for this work" }
end
