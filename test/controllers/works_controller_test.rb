require "test_helper"

describe WorksController do
  before do
    @work = works(:test_work)
  end

  let (:bad_work){
    -99999
  }

  let (:new_work_hash){
      {
        work: {
        category: "movie",
        description: "We love a good test on updated work"
      },
    }
  }

  describe "root" do
    it "can get the root path" do
      get root_url
      must_respond_with :success
    end
  end

  describe "index" do
    it "must get index" do
      get works_url
      must_respond_with :success
    end

    it "doesnt break when movies, albums, or books are nil" do
      skip
      # idk how to test this
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
      skip
    end

    it "wont create a work if data is wrong" do
      skip
    end

  end

  describe "show" do
    it "must get show" do
      get works_url(@work.id)
      must_respond_with :success
    end

    it "redirects to error page for invalid work" do
      skip
      get works_url(bad_work)
      # must redirect somewhereeeeee
    end
  end


  describe "edit" do
    it "can get the edit page go an existing task" do
      get edit_work_url(@work.id)
      must_respond_with :success
    end

    it "redirects to error page when attempting to edit a nonexistent work" do
      skip
      get edit_work_url(bad_work)
      # must redirect somewhereeeeee
    end
  end


  describe "update" do
    it "will update a model with a valid post reqest" do
      expect{
        patch work_url(@work.id), params: new_work_hash
    }.wont_change "Work.count"

    must_redirect_to work_url(@work.id)

    work = Work.find_by(id: @work.id)
    expect(work.category).must_equal new_work_hash[:work][:category]
    expect(work.description).must_equal new_work_hash[:work][:description]
    end

    it "will redirect for invalid work" do
      skip
    end
  end


  describe "destroy" do

    it "can destroy a model" do

      expect {delete work_url(@work.id)}.must_change "Work.count", -1

      work = Work.find_by(title: "Test")
      expect(work).must_be_nil

      must_redirect_to root_url
    end

    it "redirects for nonexistent work" do
      expect{delete work_url(bad_work)}.wont_change "Work.count", -1
      must_redirect_to root_url
    end

  end

end
