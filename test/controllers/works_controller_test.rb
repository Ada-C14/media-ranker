require "test_helper"

describe WorksController do
  before do
    @work = Work.create!(category: "book", title: "test title", creator: "test creator", publication_year: 2020, description: "test description")
  end

  describe "index" do
    it "should get index" do
      get "/works"
      must_respond_with :success
    end
  end

  describe "show" do
    it "will get show for valid ids" do
      # Arrange
      valid_work_id = @work.id

      # Act
      get "/works/#{valid_work_id}"

      # Assert
      must_respond_with :success
    end

    it "will respond with not_found for invalid ids" do
      # Arrange
      invalid_work_id = -1

      # Act
      get "/works/#{invalid_work_id}"

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new_work_path" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    let (:work_hash) {
      {
          work: {
              category: "book",
              title: "test title 2",
              creator: "test creator",
              publication_year: 2020,
              description: "test description"
          }
        }
      }

    it "can create a work" do
      expect {
        post works_path, params: work_hash
      }.must_differ 'Work.count', 1

      new_work = Work.find_by(title: work_hash[:work][:title])

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)

      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(new_work.description).must_equal work_hash[:work][:description]
    end

    it "will not create a work with invalid params" do
      work_hash[:work][:title] = nil

      expect {
        post works_path, params: work_hash
      }.must_differ "Work.count", 0

      must_respond_with :bad_request
    end
  end

  describe "update" do
    let (:new_work_hash) {
      {
          work: {
              category: "book",
              title: "title",
              creator: "creator",
              publication_year: 2021,
              description: "description"
          },
        }
     }
    it "will update a model with a valid post request" do
      id = Work.first.id
      expect {
        patch work_path(id), params: new_work_hash
      }.wont_change "Work.count"

      must_respond_with :redirect

      work = Work.find_by(id: id)
      expect(work.category).must_equal new_work_hash[:work][:category]
      expect(work.title).must_equal new_work_hash[:work][:title]
      expect(work.creator).must_equal new_work_hash[:work][:creator]
      expect(work.publication_year).must_equal new_work_hash[:work][:publication_year]
      expect(work.description).must_equal new_work_hash[:work][:description]
    end

    it "will respond with not_found for invalid ids" do
      id = -1

      expect {
        patch work_path(id), params: new_work_hash
      }.wont_change "Work.count"

      must_respond_with :not_found
    end

    it "will not update if the params are invalid" do
      new_work_hash[:work][:title] = nil
      work = Work.first

      expect {
        patch work_path(work.id), params: new_work_hash
      }.wont_change "Work.count"

      work.reload # refresh the work from the database
      must_respond_with :bad_request
      expect(work.title).wont_be_nil
    end
  end

  describe 'destroy' do
    it 'destroys the work instance in db when work exists, then redirects to root_path' do
      new_work = Work.new(category: "book", title: "test title 3", creator: "test creator", publication_year: 2020, description: "test description")
      new_work.save!
      id = new_work.id

      # Act
      expect do
        delete work_path(id)
        # Assert
      end.must_change 'Work.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it 'does not change the db when the work does not exist, then responds with 404' do
      id = -1

      expect do
        delete work_path(id)
      end.wont_change 'Work.count'

      must_respond_with :not_found
    end
  end
end
