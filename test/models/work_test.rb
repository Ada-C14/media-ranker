require "test_helper"

describe "Work" do
  describe "validations" do
    it "validates that it has a title" do
      media = Work.first
      media.title = nil

      expect(media.valid?).must_equal false
      expect(media.errors.messages).must_include :title
      expect(media.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "validates that it has a category" do
      media = Work.first
      media.category = nil

      expect(media.valid?).must_equal false
      expect(media.errors.messages).must_include :category
      expect(media.errors.messages[:category]).must_equal ["can't be blank"]
    end
  end
  # describe "relationships" do
  #   it "can have many users" do
  #     media = Work.first
  #     user = User.first
  #     user_two = User.last
  #   end
  # end

  describe "spotlight" do
    it "selects a media to spotlight" do
      spotlight = Work.select_spotlight
      # binding.pry
      expect(spotlight.title).must_equal "Joe Treat"
    end
  end

  describe "top ten media" do
    it "can select top ten" do
      top_ten = Work.top_ten("book")
      # binding.pry
      expect(top_ten.count).must_equal 10
    end

    # it "redirects if there's 0 media available for top ten" do
    #   test movie (0 in test db)
    # end
    #
    # it "redirects if there's less than ten top works" do
    #   test albums (less than 10)
    # end

  end
end

