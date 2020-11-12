class Work < ApplicationRecord

  def self.spotlight
    spotlight_for_all_works = Work.all.sample

    return spotlight_for_all_works
  end
end

