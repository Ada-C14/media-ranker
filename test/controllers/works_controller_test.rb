require 'test_helper'

describe WorksController do

  describe 'index' do
    it "gets index" do
      get "/works"
      must_respond_with :success
    end
  end

  describe 'show' do
    before do
      @work = Work.first
    end

    it 'will get show for valid ids' do
      valid_work_id = @work.id

      get "/works/#{valid_work_id}"

      must_respond_with :success

    end

    it 'will respond with redirect for invalid ids' do
      get "/works/-1"

      must_redirect_to root_path
    end
  end

  describe 'new' do
    it 'can get the new work path' do
      get new_work_path

      must_respond_with :success
    end
  end

  describe 'create' do
    it 'creates a new work' do
      work_info = {
          work: {
              category: 'Book',
              title: "A Book",
              creator: "An Author",
              publication_year: 1999,
              description: "The world's greatest description"
          }
      }

      expect {
        post works_path, params: work_info
      }.must_differ "Work.count", 1

      must_respond_with :redirect
      expect(Work.last.title).must_equal work_info[:work][:title]
      expect(Work.last.creator).must_equal work_info[:work][:creator]
    end

    it 'requires a title to create a work, does not creat a work otherwise and responds with 400' do
      work_info = {
          work: {
              category: 'Book',
              title: nil,
              creator: "An Author",
              publication_year: 1999,
              description: "The world's greatest description"
          }
      }

      expect {
        post works_path, params: work_info
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end

    it 'requires a category to create a work, does not create a work otherwise and responds with 400' do
      work_info = {
          work: {
              category: nil,
              title: "A Title",
              creator: "An Author",
              publication_year: 1999,
              description: "The world's greatest description"
          }
      }

      expect {
        post works_path, params: work_info
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe 'edit' do
    it 'can get the edit page for a valid work' do
      id = Work.first.id

      get edit_work_path(id)

      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistent work' do
      get edit_work_path(-1)
      must_redirect_to root_path
    end
  end

  describe 'update' do
    let (:new_info) {
      {work: {
            category: "album",
            title: "This is a new title",
            creator: "This is the new creator"
        }
      }
    }
    it 'updates an existing work, does not create a new record' do
      id = Work.last.id


      expect {
        patch work_path(id), params: new_info
      }.wont_change "Work.count"

      must_redirect_to work_path(id)

      updated_work = Work.find_by(id: id)

      expect(updated_work.category).must_equal new_info[:work][:category]
      expect(updated_work.title).must_equal new_info[:work][:title]
      expect(updated_work.creator).must_equal new_info[:work][:creator]
    end

    it 'responds with redirect for invalid ids' do
      expect {
        patch work_path(-1), params: new_info
      }.wont_change "Work.count"

      must_respond_with :redirect
    end

    it "will not update if the params are invalid" do
      new_info[:work][:category] = nil
      work = Work.first

      expect {
        patch work_path(work.id), params: new_info
      }.wont_change "Work.count"
      work.reload
      must_respond_with :bad_request
      expect(work.title).wont_be_nil
    end
  end

  describe 'destroy' do
    it "destroys the work from the db, then redirects" do
      id = Work.first.id

      expect {
        delete work_path(id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path
    end

    it 'does not change the db when the work does not exist and responds with redirect' do
      expect {
        delete work_path(-1)
      }.wont_change "Work.count"

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe 'main' do
    it 'can get the main page' do
      get root_path

      must_respond_with :success
    end

    it 'can get the main page if there are no records' do
      Work.all.each do |work|
        work.destroy
      end

      get root_path
      must_respond_with :success
    end
  end
end
