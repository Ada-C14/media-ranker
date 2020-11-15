require "test_helper"

describe Work do
  it "can be instantiated" do
    # Assert
    expect(works(:book).valid?).must_equal true
  end

  it "has required fields" do
    work = Work.first
    expect(work).must_respond_to :category
    expect(work).must_respond_to :title
  end

  describe "validations" do
    it "must have a title" do
      works(:book).title = nil

      expect(works(:book).valid?).must_equal false
      expect(works(:book).errors.messages).must_include :title
      expect(works(:book).errors.messages[:title]).must_equal ["can't be blank"]
    end

  end

  describe "relationships" do
    it "can have many votes" do
      expect(works(:work2).votes.first).must_be_instance_of Vote
      expect(works(:work2).votes.last).must_be_instance_of Vote
      expect(works(:work2).votes.count).must_equal 2
      expect(votes(:vote1).user).must_equal users(:user1)
    end
  end

  describe "spotlight" do
    it "returns top Work with most votes" do
      top_work = works(:work2)
      expect(Work.spotlight).must_be_instance_of Work
      expect(Work.spotlight).must_equal top_work
      expect(Work.spotlight.votes.count).must_equal 2
    end
  end
  
end
