require "test_helper"

describe WorksController do
  before do
    @work = Work.create category:'book', title:'The Giver', creator:'Lois Lowry', publication_year:'1993', description:'Childrens book'
  end

  describe "index" do
    it "responds with success when there are many works saved" do
      # Arrange
      # Ensure that there is at least one work saved

      # Act
      get works_path

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no works saved" do
      # Arrange
      # Ensure that there are zero works saved
      @work.destroy

      # Act
      get works_path

      # Assert
      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid work" do
      # Arrange
      # Ensure that there is a work saved

      # Act
      get work_path(@work.id)

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid work id" do
      # Arrange
      # Ensure that there is an id that points to no work

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
      # Set up the form data
      work_hash = {
        work: {
          category: 'book',
          title: 'test title',
          creator: 'test author',
          publication_year: '1984',
          decription: 'this is a test'
        }
      }

      # Act-Assert
      # Ensure that there is a change of 1 in work.count
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      # Assert
      # Find the newly created work, and check that all its attributes match what was given in the form data
      # Check that the controller redirected the user
      new_work = work.find_by(name: work_hash[:work][:title])
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.creator).must_equal work_hash[:work][:creator]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)

    end

    it "does not create a work if the form data violates work validations" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates work validations
      work_hash = {
          work: {
              category: '',
              title: '',
              creator: 'test author',
              publication_year: '1984',
              decription: 'this is a test'
          }
      }
      # Act-Assert
      expect {
        post works_path, params: work_hash
      }.wont_differ "Work.count"

    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid work" do
      # Arrange
      # Ensure there is an existing work saved

      # Act
      get edit_work_path(@work.id)

      # Assert
      must_respond_with :success

    end

    it "responds with redirect when getting the edit page for a non-existing work" do
      # Arrange
      # Ensure there is an invalid id that points to no work

      # Act
      get edit_work_path(-1)

      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do
    it "can update an existing work with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing work saved
      # Assign the existing work's id to a local variable
      id = @work.id
      # Set up the form data
      work_hash = {
          work: {
              category: 'book',
              title: 'test title',
              creator: 'test author',
              publication_year: '1984',
              decription: 'this is a test'
          }
      }

      # Act-Assert
      # Ensure that there is no change in work.count
      expect {
        patch work_path(id), params: work_hash
      }.wont_differ "work.count"

      # Assert
      # Use the local variable of an existing work's id to find the work again, and check that its attributes are updated
      # Check that the controller redirected the user
      new_work = work.find_by(name: work_hash[:work][:title])
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.creator).must_equal work_hash[:work][:creator]

      must_respond_with :redirect
      must_redirect_to work_path(id)

    end

    it "does not update any work if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no work
      # Set up the form data
      id = -1
      new_data = {
        work: {
          name: "new name",
          vin: "new vin"
        }
      }

      # Act-Assert
      # Ensure that there is no change in work.count
      expect {
        patch work_path(id), params: new_data
      }.wont_change "work.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found

    end

  end

  describe "destroy" do
    it "destroys the work instance in db when work exists, then redirects" do
      # Arrange
      # Ensure there is an existing work saved
      id = @work.id

      # Act-Assert
      # Ensure that there is a change of -1 in work.count
      expect {
        delete work_path(id)
      }.must_change 'work.count', -1

      # Assert
      # Check that the controller redirects
      deleted_work = work.find_by(id: id)

      expect(deleted_work).must_be_nil

      must_respond_with :redirect
      must_redirect_to works_path

    end

    it "does not change the db when the work does not exist, then responds with redirect" do
      # Arrange
      # Ensure there is an invalid id that points to no work
      @work.destroy

      # Act-Assert
      # Ensure that there is no change in work.count
      expect {
        delete work_path(@work.id)
      }.wont_differ 'work.count'

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect
      must_redirect_to works_path

    end
  end
end
