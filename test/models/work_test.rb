require "test_helper"

# All validations and should be tested
# - All custom methods should be tested
# - For top-10 or spotlight, what if there are less than 10 works? What if there are no works?
# Write at least one test for each relation on a model
# Write at least one test for each validation on a model
# Write at least one test for each custom method on a model
# Each model also needs one test where all the validations pass
#   category: movie
#   title: FirstWork
#   creator: FirstWork Creator
#   description: a description of the first work
#   publication_year: 2021


describe Work do
  it "can be instantiated" do
    new_work = Work.new(
        title: "Some Title",
        category: "album",
        creator: "Mos",
        description: "asd sdlkjf sdi sdkjr sdois s oadij slkk dkjle so di elksj eiolksdlk sskl sdlke soio",
        publication_year: 2222)

    expect(new_work.valid?).must_equal true
  end

  it "will have the following fields" do
    work = works(:work1)
    work_attributes = [:title, :category, :creator, :description, :publication_year, :vote_count]

    work_attributes.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'relations' do
    it "can have many votes" do
      work = works(:work1)

      expect(work.votes.count).must_equal 2
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many users through votes" do
      work = works(:work1)

      work.votes.each do |vote|
        expect(vote.user).must_be_instance_of User
      end
    end
  end

  describe 'validation' do
     it "must have a title" do
       work = Work.first

       expect(work.valid?).must_equal true
       expect(work.title).must_equal works(:work1).title
     end

    it "must raise errors for invalid title" do
      work = works(:work1)
      work.title = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

     it "title must be unique" do
       new_work = Work.create(title: "SecondWork")

       expect(new_work.valid?).must_equal false
       expect(new_work.errors.messages).must_include :title
       expect(new_work.errors.messages[:title]).must_equal ["has already been taken"]
     end

  end

  describe "custom methods" do
    it "top_ten method with more than ten items in a category" do
      works = Work.all
      expect(works.where(category: "album").count).must_equal 27
      expect(works.top_ten("album").count).must_equal 10
      expect(works.top_ten("album").first.title).must_equal "Work23"

    end

    it "top_ten method with less than ten items in a category" do
      second_work = works(:work2)
      second_work.increase_vote_count
      expect(second_work.vote_count).must_equal 3
      second_work.increase_vote_count
      expect(second_work.vote_count).must_equal 4

      works = Work.all
      expect(works.top_ten("movie").count).must_equal 2
      expect(works.top_ten("movie").first.title).must_equal "SecondWork"

      expect(works.top_ten("book").count).must_equal 1
      expect(works.top_ten("book").first.title).must_equal "FourthWork"
    end

    it "top_work" do
      works = Work.all
      expect(works.top_work.title).must_equal "FirstWork"
      expect(works.top_work.vote_count).must_equal 3

      second_work = works(:work2)
      second_work.increase_vote_count
      expect(second_work.vote_count).must_equal 3
      second_work.increase_vote_count
      expect(second_work.vote_count).must_equal 4

      expect(works.top_work.title).must_equal "SecondWork"
    end

    it "no top_work defaults to first work" do
      works = Work.all

      works.each do |work|
        work.vote_count = 0
      end

      expect(works.top_work.title).must_equal "FirstWork"
      expect(works.top_work.id).must_equal Work.first.id
    end

    it "increase_vote_count" do
      work = works(:work3)

      expect(work.vote_count).must_equal 0

      work.increase_vote_count

      expect(work.vote_count).must_equal 1
    end
  end
end