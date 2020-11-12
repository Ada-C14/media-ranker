class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes


  def spotlight

  end


  def self.sort_category(category)
    solo_category = Work.where(category: category)
   solo_category.each do |category|
     category.title
     category.creator
     end
   end
end



