require "test_helper"

describe Work do
  describe "validations" do
    before do
      @work = Work.new(category: "fake music", title: "fake title", creator: "fake creator", description: "fake music", publication_year: 2009)
    end

    it "is valid when all fields are present" do
      result = @work.valid?
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
    end

    it "is valid without a publication year" do
      @work.publication_year = nil
      result = @work.valid?
      expect(result).must_equal false
    end

    it "is valid without a creator" do
      @work.creator = nil
      result = @work.valid?
      expect(result).must_equal false
    end

    it "is valid without a description" do
      @work.description = nil
      result = @work.valid?
      expect(result).must_equal false
    end

    it "is invalid without a category" do
      @work.category = nil
      result = @work.valid?
      expect(result).must_equal false
    end
  end

  describe "relationships" do
    before do
      @work = Work.new(category: "fake music", title: "fake title", creator: "fake creator", description: "fake music", publication_year: 2009)
      @user = User.create(name: "fake user")
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
    end

    it "can have many votes" do
      expect(@work.votes.count).must_equal 2
    end
  end

  describe "validations" do
    before do
      @work = Work.create(category: "fake music", title: "fake title", creator: "fake creator", description: "fake music", publication_year: 1970)
      @user = User.create(name: "fake user")
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
    end

    it "is valid when all fields are present" do
      result = @vote.valid?
      expect(result).must_equal true
    end
  end

  describe "Top Ten" do

    it "returns an empty array when there is no media" do
      Work.destroy_all
      best_books = Work.top_ten("book")
      expect(best_books.length).must_equal 0
    end

    # it "generates a list of top ten category" do
    #   top_ten_books = Work.top_ten("book")
    #   expect(top_ten_books).wont_be_empty
    # end
  end

  describe "spotlight" do

    it "returns media by the highest number of votes" do
      6.times do
        Vote.create(user_id: User.last.id, work_id: 1)
      end

      expect(Work.spotlight.votes.count).must_equal 6
    end
  end
end
