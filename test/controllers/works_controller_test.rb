require "test_helper"

describe WorksController do

  describe 'index' do
    it "gets index" do
      get "/works"
      must_respond_with :success
    end
  end

  describe 'show' do
    before do
      @work = Work.create(category: "book", title: "Test Book", creator: "Test Creator", publication_year: 2020, description: "Test Descrition")
    end

    it 'will get show for valid ids' do
      # valid_work_id = @work.id

      get work_path(@work.id)


      must_respond_with :success

    end

    it 'will respond with not found for invalid ids' do

      get work_path(-1)

      must_respond_with :not_found
    end
  end

  describe 'new' do
    it 'can get the new work path' do
      get new_work_path

      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new work with valid information accurately, and redirect' do
      work_hash = {
          work: {
              category: 'Book',
              title: "Test Book",
              creator: "Test Creator",
              publication_year: 2020,
              description: "Test Description"
          }
      }

      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(category: work_hash[:work][:category])

      must_respond_with :redirect
      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.creator).must_equal work_hash[:work][:creator]

    end

    it "does not create a work if the form data violates Work validations, and responds with 400" do

      empty_work = {work: {category: nil, title: nil, creator: nil}}


      expect{
        post works_path, params: empty_work
      }.wont_change "Work.count"

      assert_response :bad_request

    end
  end

  describe 'edit' do
    before do
      @work = Work.create(category: "book", title: "Test Book", creator: "Test Creator", publication_year: 2020, description: "Test Descrition")
    end

    it 'responds with success when getting the edit page for an existing, valid work' do
      get edit_work_path(@work.id)


      must_respond_with :success
    end

    it 'will respond with not found for invalid ids' do

      get edit_work_path(-1)

      must_respond_with :not_found
    end

  end

  describe 'update' do
    before do
      @work = Work.create(category: "book", title: "Test Book", creator: "Test Creator", publication_year: 2020, description: "Test Descrition")
    end
    let (:new_work_hash) {
      {work: {
              category: 'Book',
              title: "Test Book",
              creator: "Test Creator",
              publication_year: 2020,
              description: "Test Description"
          }
      }
    }

    it "can update an existing work with valid information accurately, and redirect" do
      id = Work.first.id

      expect {
        patch work_path(id), params: new_work_hash
      }.wont_change "Work.count"

      must_respond_with :redirect

      updated_work = Work.find_by(id: id)

      expect(updated_work.category).must_equal new_work_hash[:work][:category]
      expect(updated_work.title).must_equal new_work_hash[:work][:title]
      expect(updated_work.creator).must_equal new_work_hash[:work][:creator]
    end

    it "does not update any work if given an invalid id, and responds with a 404" do

      expect {
        patch work_path(-1), params: new_work_hash
      }.wont_change 'Work.count'

      must_respond_with :not_found

    end

    it "does not create a work if the form data violates Work validations, and responds with 400" do

      empty_work = {work: {category: nil, title: nil, creator: nil}}


      expect{
        post works_path, params: empty_work
      }.wont_change "Work.count"

      assert_response :bad_request

    end

  end

  describe "destroy" do
    it 'destroys the work instance in db when work exists, then redirects' do
      work = Work.create(category: "book", title: "Test Book", creator: "Test Creator", publication_year: 2020, description: "Test Descrition")

      id = work.id

      expect {
        delete work_path(id)
      }.must_change "Work.count", -1
      
      must_respond_with :redirect
      must_redirect_to works_path
    end

    it 'does not change the db when the work does not exist and responds with not_found' do
      expect {
        delete work_path(-1)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end

end
