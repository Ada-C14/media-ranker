require "test_helper"

describe WorksController do
  describe "index" do
    it "responds with success when there are many works saved" do
      # Arrange
      Work.create category: "movie", title: "chao in space"
      # Act
      get works_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no works saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act
      get works_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    # Arrange
    before do
      Work.create(category:"movie", title: "cars vhs")
    end
    it "responds with success when showing an existing valid work" do
      # Arrange
      id = Work.find_by(category:"movie")[:id]

      # Act
      get work_path(id)

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid user id" do
      # Act
      get work_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      # Act
      get new_work_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work with valid information accurately, and redirect" do
      # Arrange
      work_hash = {
        work: {
          category: "album",
          title: "bring it to the runway",
        },
      }

      # Act-Assert
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.category).must_equal work_hash[:work][:category]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)

    end

    it "does not create a work if the form data violates Work validations, rendering form with bad request" do
      # Arrange
      empty_work = {work: {category:nil, title:nil}}

      # Act-Assert
      expect {
        post works_path, params: empty_work
      }.wont_change "Work.count"

      # success indicates rendering of page
      assert_response :bad_request
    end
  end

  describe "edit" do
    before do
      Work.create(category:"movie", title: "cars vhs")
    end
    it "responds with success when getting the edit page for an existing, valid work" do
      # Arrange
      id = Work.find_by(title:"cars vhs")[:id]

      # Act
      get edit_work_path(id)
      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing work" do
      # Act
      get edit_work_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      Work.create(category:"movie", title: "cars vhs")
    end
    let (:edit_work_data) {
      {
        work: {category: "album",
               title:"live and learn"}
      }
    }
    it "can update an existing work with valid information accurately, and redirect" do
      # Arrange
      id = Work.find_by(title:"cars vhs")[:id]
      # Act-Assert
      expect{
        patch work_path(id), params: edit_work_data
      }.wont_change "Work.count"

      must_redirect_to work_path(id)

      edited_work = Work.find_by(title: edit_work_data[:work][:title])
      expect(edited_work.category).must_equal edit_work_data[:work][:category]

    end

    it "does not update any work if given an invalid id, and responds with a 404" do
      id = -1
      # Act-Assert
      expect {
        patch work_path(id), params: edit_work_data
      }.wont_change "Work.count"

      must_respond_with :not_found

    end

    it "does not update work if the form data violates Work validations, and responds by rendering form with errors listed" do
      # Arrange
      id = Work.find_by(title:"cars vhs")[:id]
      work = Work.find_by(id: id)
      empty_work = {work: {category:nil, title:nil}}

      # Act-Assert
      expect {
        patch work_path(id), params: empty_work
      }.wont_change "Work.count"

      work.reload
      must_respond_with :bad_request
      expect(work.category).wont_be_nil
      expect(work.title).wont_be_nil
    end
  end

  describe "destroy" do
    it "destroys the work in db when work exists, then redirects" do
      # Arrange
      delete_me = Work.new category: "movie", title: "Delete me"

      delete_me.save
      id = delete_me.id

      # Act
      expect {
        delete work_path(id)

        # Assert
      }.must_change 'Work.count', -1

      assert_nil(Work.find_by(title: delete_me.title))

      must_respond_with :redirect
      must_redirect_to root_path


    end

    it "deletes any votes associated with a deleted work" do
      # Arrange
      work = Work.create(category: 'book', title: "delete the vote")
      user = User.create(username: "shadow")
      user.save
      vote = Vote.create(work_id: work.id, user_id: user.id)
      user_id = user.id
      work_id = work.id
      # Act
      expect {
        delete work_path(work_id)
      }.must_change "Vote.count", -1

      deleted_vote = Vote.find_by(user_id: user_id)

      # Assert
      expect(deleted_vote).must_be_nil
      must_respond_with :redirect
      must_redirect_to root_path
      expect(user.votes.count).must_equal 0
    end

    it "does not change the db when the work does not exist, then responds with 404" do
      # Act
      expect {
        delete work_path(-1)

        # Assert
      }.wont_change 'Work.count'

      must_respond_with :not_found
    end
  end
end
