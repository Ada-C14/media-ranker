require "test_helper"

describe User do
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

  describe "instantiation" do
    it "can be instantiated" do
      expect(@user.valid?).must_equal true
    end

    it "will have the required fields" do
      [:name].each do |field|
        expect(@user).must_respond_to field
      end
    end
  end

  describe "relations" do
    it "can have many votes" do
      Vote.create!(user_id: @user.id, work_id: second_work.id)
      expect(@user.votes.count).must_equal 2
    end

    it "has many works through votes" do
      Vote.create!(user_id: @user.id, work_id: second_work.id)
      expect(@user.works.length).must_equal 2
    end
  end

  describe "validations" do

    it "cant be created without a username" do
      @user.name = nil
      result = @user.valid?
      expect(result).must_equal false
    end
  end

end
