require "test_helper"

describe WorksController do

  let (:work) {
    works(:dead_alive)
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

    let(:work_hash){
      {
          work: {
              title: "Bad Taste",
              creator: "Peter Jackson",
              publication_date: 1980,
              description: "Classic splatter-comedy",
              category: "movie"
          }
      }
    }

    it "can create a new work" do

      # Act-Assert
      expect{
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.publication_date).must_equal work_hash[:work][:publication_date]
      expect(new_work.description).must_equal work_hash[:work][:description]
      expect(new_work.category).must_equal work_hash[:work][:category]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it 'will respond with error if title is blank' do

      work_hash[:work][:title] = ""

      expect{
        post works_path, params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not create movie"
      expect(flash[:error]["errors"][0]).must_equal "title: can't be blank"

      must_respond_with :bad_request
    end

    it 'will respond with error if category is blank string' do
      work_hash[:work][:category] = ""

      expect{
        post works_path, params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not create work"
      expect(flash[:error]["errors"][0]).must_equal "category: can't be blank"

      must_respond_with :bad_request
    end

    it 'will respond with error if category is nil' do
      work_hash[:work][:category] = nil

      expect{
        post works_path, params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not create work"
      expect(flash[:error]["errors"][0]).must_equal "category: can't be blank"

      must_respond_with :bad_request
    end

    it 'will respond with error with non-int publication date' do
      work_hash[:work][:publication_date] = "vvv"

      expect{
        post works_path, params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not create movie"
      expect(flash[:error]["errors"][0]).must_equal "publication date: is not a number"

      must_respond_with :bad_request
    end

    it 'will respond with error if publication_date is < 0' do
      work_hash[:work][:publication_date] = -1984

      expect{
        post works_path, params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not create movie"
      expect(flash[:error]["errors"][0]).must_equal "publication date: must be greater than 0"

      must_respond_with :bad_request
    end

    it 'will respond with error if publication_date > 2100' do
      work_hash[:work][:publication_date] = 3000

      expect{
        post works_path, params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not create movie"
      expect(flash[:error]["errors"][0]).must_equal "publication date: must be less than or equal to 2100"

      must_respond_with :bad_request
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

    let(:work_hash){
      {
          work: {
              title: "Mulholland Dr",
              creator: "David Lynch",
              publication_date: 2001,
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
      expect(test_work.publication_date).must_equal work_hash[:work][:publication_date]
      expect(test_work.description).must_equal work_hash[:work][:description]
      expect(test_work.category).must_equal work_hash[:work][:category]

      expect(flash[:success]).must_equal "Successfully updated movie #{id}"
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      patch work_path(id), params: work_hash
      must_redirect_to works_path
    end

    it 'will respond with error if title is blank' do

      work_hash[:work][:title] = ""

      id = Work.first.id
      expect{
        patch work_path(id), params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not update movie"
      expect(flash[:error]["errors"][0]).must_equal "title: can't be blank"

      must_respond_with :bad_request
    end

    it 'will respond with error if category is blank string' do
      work_hash[:work][:category] = ""

      id = Work.first.id
      expect{
        patch work_path(id), params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not update work"
      expect(flash[:error]["errors"][0]).must_equal "category: can't be blank"

      must_respond_with :bad_request
    end

    it 'will respond with error if category is nil' do
      work_hash[:work][:category] = nil

      id = Work.first.id
      expect{
        patch work_path(id), params: work_hash
      }.wont_change "Work.count"


      expect(flash[:error]["failed_action"]).must_equal "could not update work"
      expect(flash[:error]["errors"][0]).must_equal "category: can't be blank"

      must_respond_with :bad_request
    end

    it 'will respond with error with non-int publication date' do
      work_hash[:work][:publication_date] = "vvv"

      id = Work.first.id
      expect{
        patch work_path(id), params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not update movie"
      expect(flash[:error]["errors"][0]).must_equal "publication date: is not a number"

      must_respond_with :bad_request
    end

    it 'will respond with error if publication_date is < 0' do
      work_hash[:work][:publication_date] = -1984

      id = Work.first.id
      expect{
        patch work_path(id), params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not update movie"
      expect(flash[:error]["errors"][0]).must_equal "publication date: must be greater than 0"

      must_respond_with :bad_request
    end

    it 'will respond with error if publication_date > 2100' do
      work_hash[:work][:publication_date] = 3000

      id = Work.first.id
      expect{
        patch work_path(id), params: work_hash
      }.wont_change "Work.count"

      expect(flash[:error]["failed_action"]).must_equal "could not update movie"
      expect(flash[:error]["errors"][0]).must_equal "publication date: must be less than or equal to 2100"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
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

  describe 'upvote' do

    before do
      perform_login(users(:me))
    end

    it 'will increase the votes of voted-on work' do
      expect{
        post upvote_work_path(work.id)
      }.must_change 'work.votes.count', 1

      must_redirect_to work_path(work.id)

      expect(flash[:success]).must_equal "Successfully upvoted!"
    end

    it 'will respond with error msg if same user tries to vote twice' do

      post upvote_work_path(work.id)

      expect{
        post upvote_work_path(work.id)
      }.wont_change 'work.votes.count'

      expect(flash[:error]["failed_action"]).must_equal "A problem occurred: Could not upvote"
      expect(flash[:error]["errors"][0]).must_equal "user: has already voted for this work"

      must_respond_with :bad_request
    end

    it "will redirect to the root page if given an invalid id" do
      # Your code here
      id = -1
      post upvote_work_path(id)
      must_redirect_to works_path
    end
  end
end
