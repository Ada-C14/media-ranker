require "test_helper"

describe Work do
  let(:new_work) {
    Work.new(
        category: "album",
        title: "test title",
        creator: "test creator",
        publication_year: "2020",
        description: "test description"
    )
  }
  it "has all the required fields" do
    new_work.save
    work = Work.first

    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end

  it 'must be valid when all fields are present' do
    new_work.save
    expect(new_work.valid?).must_equal true
  end

  it 'is invalid without a title' do
    new_work.title = nil

    expect(new_work.valid?).must_equal false
    expect(new_work.errors.messages).must_include :title
    expect(new_work.errors.messages[:title]).must_include "can't be blank"
  end

  it "is invalid when the title in not unique" do
    new_test_work = Work.new(
        {
            category: "album",
            title: "test title",
        }
    )
    # Work.create!(title: new_work.title)
    new_test_work.save
    expect(new_test_work.valid?).must_equal false
    expect(new_test_work.errors.messages[:title].include?("has already been taken"))
  end

  describe "relations" do
    it "has many votes" do
      test_work = works(:work_1)
      expect(test_work.votes.count).must_equal 2
      test_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many users through votes" do
      test_work = works(:work_5)
      expect(test_work.votes.count).must_equal 1
      test_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe "custom methods" do
    it "returns the work with the max vote" do
      expect(Work.spotlight).must_equal works(:work_3)
      test_vote_count = []
      works.each do |work|
        test_vote_count << work.votes.count
      end
      expect(test_vote_count.max).must_equal works(:work_3).votes.count
    end

    it "returns the work with the lowest title length if it's tied" do
      Vote.create(work_id: works(:work_3).id, user_id: users(:user_3).id)
      spotlight = Work.spotlight
      expect(spotlight).must_equal works(:work_3)
    end
  end

  describe "to_ten method" do
    it "returns (max)ten top works in each category" do
      category = "book"
      top_books = Work.top_ten(category)
      expect(top_books.count).must_be :<=, 10
      expect(top_books.count).must_equal 2

      check_votes_num = top_books[0].votes.count >= top_books[1].votes.count
      expect(check_votes_num).must_equal true
    end
  end
end







