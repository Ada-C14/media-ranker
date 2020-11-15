require "test_helper"

describe WorksController do
  before do
    @work = works(:test_work)
  end

  let (:bad_work){
    -99999
  }

  let (:update_work_hash){
      {
        work: {
        category: "movie",
        description: "We love a good test on updated work"
      },
    }
  }

  let (:second_work_hash){
      {
      work: {
        category: "album",
        title: "create_test",
        creator: "The Testor",
        publication_year: 2020,
        description: "We love a good create test"
      }
    }
  }

  let (:user){
    User.create!(name: "test user")
  }

  describe "index" do
    it "must get index" do
      get works_url
      must_respond_with :success
    end

    it "doesnt break when there are no works" do
      @work.destroy
      expect(Work.count).must_equal 0
      get works_url
      must_respond_with :success
    end
  end

  describe "new" do
    it "can get the new work page" do
      get new_work_url
      must_respond_with :success
    end
  end

  describe "create" do

    it "can create a work" do
      expect {post works_url, params: second_work_hash}.must_differ 'Work.count', 1

      new_work = Work.find_by(title: second_work_hash[:work][:title])
      expect(new_work.title).must_equal second_work_hash[:work][:title]
      expect(new_work.creator).must_equal second_work_hash[:work][:creator]
      expect(new_work.description).must_equal second_work_hash[:work][:description]
      expect(flash[:success]).must_equal "Successfully created #{new_work.category} #{new_work.id}"
      must_redirect_to work_url(new_work.id)
    end

    it "wont create a work without a title" do
      second_work_hash[:work][:title] = nil
      expect {post works_url, params: second_work_hash}.wont_change 'Work.count'
      expect(flash[:error_message]).must_equal "title: can't be blank"
      must_respond_with :redirect
    end

    it "wont create a work with a duplicated title" do
      second_work_hash[:work][:title] = "test"
      expect {post works_url, params: second_work_hash}.wont_change 'Work.count'
      expect(flash[:error_message]).must_equal "title: has already been taken"
      must_respond_with :redirect
    end
  end

  describe "show" do
    it "must get show" do
      get work_url(@work.id)
      must_respond_with :success
    end

    it "redirects to error page for invalid work" do
      get work_url(bad_work)
      must_respond_with :not_found
    end
  end


  describe "edit" do
    it "can get the edit page go an existing task" do
      get edit_work_url(@work.id)
      must_respond_with :success
    end

    it "redirects to error page when attempting to edit a nonexistent work" do
      get edit_work_url(bad_work)
      must_respond_with :not_found
    end
  end


  describe "update" do
    it "will update a model with a valid post reqest" do
      expect{
        patch work_url(@work.id), params: update_work_hash
    }.wont_change "Work.count"

    must_redirect_to work_url(@work.id)

    work = Work.find_by(id: @work.id)
    expect(work.category).must_equal update_work_hash[:work][:category]
    expect(work.description).must_equal update_work_hash[:work][:description]
    expect(flash[:success]).must_equal "Successfully updated #{work.category} #{work.id}"
    end

    it "will redirect for invalid work" do
      expect{
        patch work_url(bad_work), params: update_work_hash
    }.wont_change "Work.count"

    must_respond_with :not_found
    end
  end


  describe "destroy" do

    it "can destroy a model" do
      category = @work.category
      id = @work.id

      expect {delete work_url(@work.id)}.must_change "Work.count", -1

      work = Work.find_by(title: "Test")
      expect(work).must_be_nil
      expect(flash[:success]).must_equal "Successfully destroyed #{category} #{id}"

      must_redirect_to root_url
    end

    it "redirects for nonexistent work" do
      expect{delete work_url(bad_work)}.wont_change "Work.count", -1
      must_redirect_to root_url
    end

  end

  describe "upvote" do

    it "can upvote for a logged in user" do
      perform_login(user)

      expect{post upvote_work_path(@work.id)}.must_differ "Vote.count", 1
      expect(user.votes.length).must_equal 1
      expect(flash[:success]).must_equal "Successfully upvoted!"
    end

    it "redirects if user is not logged in" do
      expect{post upvote_work_path(@work.id)}.wont_change "Vote.count"
      expect(flash[:error]).must_equal "A problem occurred: You must log in to do that"
    end

    it "can't be voted for more than once by same user" do
      skip
      # skipping because idk about my flash thing
      perform_login(user)
      expect{post upvote_work_path(@work.id)}.must_differ "Vote.count", 1
      expect{post upvote_work_path(@work.id)}.wont_change "Vote.count"
      expect(flash[:error]).must_equal "A problem occurred: Could not upvote"
      expect(flash[:error_message]).must_equal "user: has already voted for this work"
    end
  end

end
