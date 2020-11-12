require "test_helper"

describe Work do

  before do
    @work = works(:test_work)
    @user = User.create!(name: "test user")
    @vote = Vote.create!(user_id: @user.id, work_id: @work.id)
  end
  let (:second_work){
    Work.create!(
      category: "album",
      title: "second test",
      creator: "The Testor",
      publication_year: 2020,
      description: "We love a good create test")
    }
    let (:second_user){
      User.create!(
        name: "second test user"
      )
    }

  describe "instantiation" do
    it "can be instantiated" do
      expect(@work.valid?).must_equal true
    end

    it "will have the required fields" do
      [:category, :title, :creator, :publication_year, :description].each do |field|
        expect(@work).must_respond_to field
      end
    end
  end
  
  describe "relations" do
    it "can have many votes" do
      Vote.create!(user_id: second_user.id, work_id: @work.id)
      expect(@work.votes.count).must_equal 2
    end

    it "has many users through votes" do
      Vote.create!(user_id: second_user.id, work_id: @work.id)
      expect(@work.users.length).must_equal 2
    end
  end

  describe "validations" do
    it "is invalid without a title" do
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "is invalid with a non-unique title for a given category" do
      second_work.title = "test"
      result = second_work.valid?
      expect(result).must_equal false
    end

    it "is valid for a non-unique title with a different category" do
      second_work.title = "test"
      second_work.category = "movie"
      result = second_work.valid?
      expect(result).must_equal true
    end
  end

  describe "select spotlight" do
    it "can select the spotlight" do
      Vote.create!(user_id: @user.id, work_id: second_work.id)
      Vote.create!(user_id: second_user.id, work_id: @work.id)

      expect(@work.votes.length).must_equal 2
      expect(second_work.votes.length).must_equal 1
      expect(Work.select_spotlight).must_equal @work
    end

    it "chooses alphabetically in the chance of ties" do
      Vote.create!(user_id: @user.id, work_id: second_work.id)

      expect(@work.votes.length).must_equal 1
      expect(second_work.votes.length).must_equal 1
      expect(Work.select_spotlight).must_equal second_work
    end

    it "returns nil in the case of no votes" do
      @vote.destroy

      expect(Vote.count).must_equal 0
      expect(Work.select_spotlight).must_be_nil
    end
  end

  describe "select top 10 media" do
    it "can select the top 10 media" do
      skip
    end

    it "returns nothing in the case of no votes" do
      skip
    end

    it "picks the first 10 works it sees in the case of ties" do
      skip
    end
  end

end
