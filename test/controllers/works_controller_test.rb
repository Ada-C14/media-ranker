require "test_helper"

describe WorksController do

  let (:work) {
    Work.create!(title: "Dead Alive",
                creator: "Peter Jackson",
                publication_date: Time.new("1980"),
                description: "Classic splatter-comedy",
                category: "movie")
  }
  describe 'index' do
    it "must get index" do
      get works_path
      must_respond_with :success
    end
  end

  describe 'new' do
    it "must get new" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe 'create' do
    it "can create a new work" do

      # Arrange
      work_hash = {
          work: {
              title: "DeadAlive",
              creator: "Peter Jackson",
              publication_date: Time.new("1980"),
              description: "Classic splatter-comedy",
              category: "movie"
          }
      }

      # Act-Assert
      expect{
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.publication_date.to_time).must_equal work_hash[:work][:publication_date]
      expect(new_work.description).must_equal work_hash[:work][:description]
      expect(new_work.category).must_equal work_hash[:work][:category]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end
  end

  describe 'edit' do
    it "can get the edit page for an existing work" do
      get edit_work_path(work.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant work" do
      get edit_work_path(-1)

      must_respond_with :redirect
    end
  end

  describe "show" do
    it "can get a valid show" do

      # Act
      get work_path(work.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid show" do

      # Act
      get work_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "update" do
    before do
      Work.create!(title: "Dead Alive",
                   creator: "Peter Jackson",
                   publication_date: Time.new("1980"),
                   description: "Classic splatter-comedy",
                   category: "movie")
    end

    let(:work_hash){
      {
          work: {
              title: "Mulholland Dr",
              creator: "David Lynch",
              publication_date: Time.new("2001"),
              description: "Cult surreal noir. Half dream.",
              category: "movie"
          }
      }
    }
    it "can update an existing work" do


      id = Work.first.id
      expect{
        patch work_path(id), params: work_hash
      }.wont_change "Work.count"

      must_respond_with :redirect

      test_work = Work.find_by(id: id)
      expect(test_work.title).must_equal work_hash[:work][:title]
      expect(test_work.creator).must_equal work_hash[:work][:creator]
      expect(test_work.publication_date.to_time).must_equal work_hash[:work][:publication_date]
      expect(test_work.description).must_equal work_hash[:work][:description]
      expect(test_work.category).must_equal work_hash[:work][:category]

    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      patch work_path(id), params: work_hash
      must_redirect_to works_path
    end
  end

  describe "destroy" do
    before do
      Work.create!(title: "Dead Alive",
                   creator: "Peter Jackson",
                   publication_date: Time.new("1980"),
                   description: "Classic splatter-comedy",
                   category: "movie")
    end
    # Your tests go here
    it "can destroy a work" do
      # Arrange
      id = Work.first.id

      # Act
      expect{
        delete work_path(id)
      }.must_change 'Work.count', -1

      test_work = Work.find_by(id: id)

      expect(test_work).must_be_nil

      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      delete work_path(id)
      must_redirect_to works_path
    end
  end
end
