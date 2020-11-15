require "test_helper"

# All validations and should be tested
# - All custom methods should be tested
# - For top-10 or spotlight, what if there are less than 10 works? What if there are no works?

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
end

describe Work do
  describe 'relations' do
     it "has an author" do
    #   book = books(:poodr)
    #   expect(book.author).must_equal authors(:metz)
    end

    it "can set the author" do
      # book = Book.new(title: "test book")
      # book.author = authors(:metz)
      # expect(book.author_id).must_equal authors(:metz).id
    end
  end
end