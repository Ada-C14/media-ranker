class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :name, presence: true, uniqueness: true, allow_blank: false
end
