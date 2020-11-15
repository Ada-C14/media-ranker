require "test_helper"

describe Vote do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #

  it "can be instantiated" do
    # Assert
    work = works(:gods)
    user = users(:ron)

    vote1 = Vote.create(user_id: user.id, work_id: work.id)
    expect(vote1.valid?).must_equal true

    vote2 = votes(:first)
    expect(vote2.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    vote = votes(:third)
    [:work_id, :user_id].each do |field|

      # Assert
      expect(vote).must_respond_to field
    end
  end

  # describe "validations" do
  #   it "must have a title" do
  #     # Arrange
  #     new_work.title = nil
  #
  #     # Assert
  #     expect(new_work.valid?).must_equal false
  #     expect(new_work.errors.messages).must_include :title
  #     expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
  #   end
  #
  #   it "must have a unique title" do
  #     new_work.save
  #     new_work_2 = Work.new(category: "book", title: "BFG", creator: "Roald Dahl", publication_year: "1982", description: "duplicate entry")
  #     new_work_2.save
  #
  #     expect(new_work_2.valid?).must_equal false
  #     expect(new_work_2.errors.messages).must_include :title
  #     expect(new_work_2.errors.messages[:title]).must_equal ["has already been taken"]
  #   end
  #
  # end

end
