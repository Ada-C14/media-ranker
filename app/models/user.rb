class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates_presence_of :name
end
