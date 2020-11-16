require "test_helper"

describe Work do
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

    it "validates that a work must be unique" do
      media = works(:treat)
      media2 = Work.create(title: media.title)

      expect(media2.valid?).must_equal false
      expect(media2.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      media = works(:treat)
      user = User.create(username: "Hugo")
      user_two = User.create(username: "Brian")
      # expect(media.votes.count).must_equal 0
      #
      vote = Vote.create(work_id: media, user_id: user)
      vote2 = Vote.create(work_id:  media, user_id: user_two)
      expect(media.votes.count).must_equal 2

      # expect(media.votes.count).must_equal 2
    end
  end

  describe "spotlight" do
    it "selects a media to spotlight" do
      spotlight = Work.select_spotlight.title

      expect(spotlight).must_equal "Joe Treat"
    end
  end

  describe "top ten media" do
    it "can select top ten" do
      top_ten = Work.top_ten("book")

      expect(top_ten.count).must_equal 10
    end

    it "redirects if there's 0 media available for top ten" do
      top_ten = Work.top_ten("movie")

      expect(top_ten.count).must_equal 0
    end
    #
    # it "redirects if there's less than ten top works" do
    #   test albums (less than 10)
    # end

  end
end

