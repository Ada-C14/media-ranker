require "test_helper"

describe WorksController do
  describe "index" do
    it "can get index" do
      get works_path
      must_respond_with :success
    end

    it "can get index even if no works" do
      Work.all.each {|work| work.delete}
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get show page" do
      # use book from fixtures
      get work_path(works(:hp1))
      must_respond_with :success
    end

    it "responds with not found / 404 if id is invalid" do
      get work_path(-1)
      must_respond_with :not_found

    end
  end

  describe "new" do
    it "can get to the new form" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    let(:work_hash) {
      {
        work: {
          category: "Movie",
          title: "Tenet",
          creator: "Christopher Nolan",
          publication_year: "2020",
          description: "A secret agent embarks on a dangerous, time-bending mission to prevent the start of World War III."
        }
      }
    }
    it "can create a work" do
      expect {
        post works_path, params: work_hash
      }.must_differ 'Work.count', 1

      tenet = Work.find_by(title: "Tenet")
      must_respond_with :redirect
      must_redirect_to work_path(tenet)
      expect(flash[:success]).wont_be_nil

      expect(tenet.category).must_equal work_hash[:work][:category]
      expect(tenet.title).must_equal work_hash[:work][:title]
      expect(tenet.creator).must_equal work_hash[:work][:creator]
      expect(tenet.publication_year).must_equal work_hash[:work][:publication_year]
      expect(tenet.description).must_equal work_hash[:work][:description]

    end

    it "will not create work if params are invalid" do
      work_hash[:work][:title] = nil

      expect {
        post works_path, params: work_hash
      }.wont_differ 'Work.count'

      expect(flash[:error]).wont_be_nil
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "can get the edit form" do
      get edit_work_path(works(:hp1))
      must_respond_with :success
    end

    it "will redirect to index page if it id doesn't exist" do
      get edit_work_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:update_hash) {
      {
        work: {
          category: "Book",
          title: "The Cuckoo's Calling",
          creator: "JK Rowling",
          publication_year: "2013",
          description: "The Cuckoo's Calling is a 2013 crime fiction novel by J. K. Rowling, published under the pseudonym Robert Galbraith."
        }
      }
    }
    it "will update work with a valid post request" do
      expect {
        patch work_path(works(:hp1)), params: update_hash
      }.wont_differ "Work.count"

      hp2 = Work.find_by(title: update_hash[:work][:title])
      must_respond_with :redirect
      must_redirect_to work_path(hp2)

      expect(flash[:success]).wont_be_nil

      expect(hp2.category).must_equal update_hash[:work][:category]
      expect(hp2.title).must_equal update_hash[:work][:title]
      expect(hp2.creator).must_equal update_hash[:work][:creator]
      expect(hp2.publication_year).must_equal update_hash[:work][:publication_year]
      expect(hp2.description).must_equal update_hash[:work][:description]
    end

    it "will not update work with invalid params" do
      update_hash[:work][:category] = nil

      expect {
        patch work_path(works(:hp1)), params: update_hash
      }.wont_differ "Work.count"

      must_respond_with :bad_request
      expect(flash[:error]).wont_be_nil
    end

    it "will redirect given an invalid work ID" do
      expect {
        patch work_path(-1), params: update_hash
      }.wont_differ "Work.count"

      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "successfully deletes work, redirects to index and reduces count by 1" do
      expect {
        delete work_path(works(:hp1))
      }.must_differ "Work.count", -1
      
      must_respond_with :redirect
      must_redirect_to works_path
      expect(flash[:success]).wont_be_nil
    end

    it "will redirect to index if invalid id" do
      expect {
        delete work_path(-1)
      }.wont_differ "Work.count"

      must_respond_with :not_found
    end
  end
end
