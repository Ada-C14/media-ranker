require "test_helper"

describe WorksController do
  let (:work) {
    Work.create(category: "book", title: "IDK How to Code", creator: "Beauttie", publication_year: 2020, description: "Story of my life")
  }

  describe "index" do
    it "responds with success when there are many works saved" do
      # data from works.yml
      expect(Work.count).must_equal 14

      get works_path

      must_respond_with :success
    end

    it "responds with success when there are no works saved" do
      Work.delete_all
      expect(Work.count).must_equal 0

      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing work" do
      get work_path(work.id)

      must_respond_with :success
    end

    it "responds with redirect with an invalid work id" do
      get work_path(-1)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "new" do
    it "responds with success" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work with valid information accurately and redirect" do
      album_hash = {
          work: {
              category: "album",
              title: "That New New",
              creator: "Anonymous",
              publication_year: 2020,
              description: "It's fire."
          }
      }

      expect {
        post works_path, params: album_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: album_hash[:work][:title])
      expect(new_work.category).must_equal album_hash[:work][:category]
      expect(new_work.creator).must_equal album_hash[:work][:creator]
      expect(new_work.publication_year).must_equal album_hash[:work][:publication_year]
      expect(new_work.description).must_equal album_hash[:work][:description]

      expect(flash[:success]).must_equal "Successfully created album"
      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it "does not create a work if the form data violates work validations, and responds with a redirect" do
      work_hash = {
          work: {
              category: "",
              title: ""
          }
      }

      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"

      expect(flash.now[:danger]).must_equal "Failed to create work"
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid work" do
      get edit_work_path(work.id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing work" do
      get edit_work_path(-1)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "update" do
    it "can update an existing work with valid information accurately and redirect" do
      work_id = work.id

      edited_work_hash = {
          work: {
              category: "album",
              title: "Decolonization of the Mind"
          }
      }

      expect {
        patch work_path(work_id), params: edited_work_hash
      }.wont_change "Work.count"

      edited_work = Work.find_by(id: work_id)
      expect(edited_work.category).must_equal edited_work_hash[:work][:category]
      expect(edited_work.title).must_equal edited_work_hash[:work][:title]

      expect(flash[:success]).must_equal "Successfully updated album"
      must_respond_with :redirect
      must_redirect_to work_path(work_id)
    end

    it "does not update any passenger if given an invalid id, and redirects to list of passengers" do
      edited_work_hash = {
          work: {
              category: "album",
              title: "Decolonization of the Mind"
          }
      }

      expect {
        patch work_path(-1), params: edited_work_hash
      }.wont_change "Work.count"

      must_respond_with :not_found
    end

    it "does not edit a work if the form data violates work validations, and responds with a redirect" do
      work_id = work.id

      edited_work_hash = {
          work: {
              category: "",
              title: ""
          }
      }

      expect {
        patch work_path(work_id), params: edited_work_hash
      }.wont_change "Work.count"

      expect(flash[:danger]).must_equal "Failed to update work"
      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "destroys the work instance in db when work exists, and then redirects" do
      work_id = work.id

      expect {
        delete work_path(work_id)
      }.must_change 'Work.count', -1

      deleted_work = Work.find_by(id: work_id)

      expect(deleted_work).must_be_nil

      expect(flash[:success]).must_equal "Successfully deleted book"
      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "does not change the db when the work does not exist, then responds with not found" do
      expect {
        delete work_path(-1)
      }.wont_change 'Work.count'

      must_respond_with :not_found
    end
  end

  describe "upvote" do
    it "allows logged-in user to vote for a work they haven't already voted for" do
      perform_login

      expect {
        post upvote_path(work.id)
      }.must_change "Vote.count", 1

      expect(flash[:success]).must_equal "Successfully upvoted"
      must_respond_with :redirect
    end

    it "does not allow a logged-in user to vote for a work they have previously voted for" do
      perform_login
      post upvote_path(work.id)

      expect {
        post upvote_path(work.id)
      }.wont_change "Vote.count"

      expect(flash[:warning]).must_equal "User has already voted for this work"
      must_respond_with :redirect
    end

    it "does not allow a guest user to vote if they have not logged in" do
      expect {
        post upvote_path(work.id)
      }.wont_change "Vote.count"

      expect(flash[:warning]).must_equal "You must be logged in to upvote!"
      must_respond_with :redirect
    end
  end
end
