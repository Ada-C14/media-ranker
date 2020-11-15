class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true

#   def top_10
#     top_10 = []
#     count = 0
#     until top_10.length == 10
#       @works.each do |work|
#         if work[count].vote.count >
#
#         end
#       end
#     end
#
end
