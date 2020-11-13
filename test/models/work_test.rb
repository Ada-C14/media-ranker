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
      @vote.destroy
      10.times do |i|
        work = Work.create!(title: "test work #{i}", category: "album")
        user =  User.create!(name: "test user #{i}")
        Vote.create!(user_id: user.id, work_id: work.id)
      end

      top_works = Work.select_top_ten("albums")
      expect(top_works.length).must_equal 10
      expect(top_works.include?(@work)).must_equal false
      expect(top_works.map{|work| work.votes.length}.all? {|votes| votes == 1}).must_equal true
    end

    it "returns nil in the case of no votes" do
      @vote.destroy
      expect(Vote.count).must_equal 0
      expect(Work.select_top_ten("albums")).must_be_nil
    end

    it "chooses alphabetically in the chance of ties" do
      Vote.create!(user_id: second_user.id, work_id: second_work.id)
      expect(Vote.count).must_equal 2
      expect(Work.select_top_ten("albums")[0]).must_equal second_work
      expect(Work.select_top_ten("albums")[1]).must_equal @work
    end
  end

end
