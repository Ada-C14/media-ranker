class Work < ApplicationRecord
  belongs_to :homepage

  def all_books
    books = []
    @works.each do |work|
      if work.category == "book"
        books << work
      end
    end
    return books
  end
end
