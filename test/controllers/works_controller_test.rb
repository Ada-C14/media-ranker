require 'test_helper'

describe WorksController do

  let (:work) {
    Work.create(
      category: 'album',
      title: 'ctrl',
      creator: 'sza',
      publication_year: 2017,
      description: 'Top Dawg Entertainment and RCA Records'
    )
  }

  let (:work_hash) {
    {
      work: {
        category: 'album',
        title: 'ctrl',
        creator: 'sza',
        publication_year: 2017,
        description: 'Top Dawg Entertainment and RCA Records'
      }
    }
  }

  let (:invalid_work_hash) {
    {
      work: {
        category: 'album',
        title: 'ctrl',
        creator: 'sza',
        publication_year: -1600,
        description: 'Top Dawg Entertainment and RCA Records'
      }
    }
  }

  describe 'index' do
    it 'responds with success when there are works saved' do
      work
      get works_path
      must_respond_with :success
    end

    it 'responds with success when there are no works saved' do
      get works_path
      must_respond_with :success
    end
  end

  describe 'show' do
    it 'responds with success when showing an existing valid work' do
      work
      get work_path(work.id)
      must_respond_with :success
    end

    it 'will redirect when passed an invalid work id' do
      get work_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'responds with success' do
      get new_work_path
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new work with valid information and redirect' do
      expect {
        post works_path, params: work_hash
      }.must_change 'Work.count', 1

      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(new_work.description).must_equal work_hash[:work][:description]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it 'does not create a work if the form data violates Work validations' do
      expect {
        post works_path, params: invalid_work_hash
      }.wont_change 'Work.count'
    end
  end

  describe 'edit' do
    it 'responds with success when getting the edit page for an existing, valid work' do
      get edit_work_path(work.id)
      must_respond_with :success
    end

    it 'responds with redirect when getting the edit page for a non-existing work' do
      get edit_work_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'update' do
    it 'can update an existing work with valid information and redirect' do
      work
      new_work = Work.first

      expect {
        patch work_path(new_work.id), params: work_hash
      }.wont_change 'Work.count'

      new_work.reload

      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(new_work.description).must_equal work_hash[:work][:description]

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
    end

    it 'does not update work if given an invalid id and redirects' do
      expect {
        patch work_path(-1), params: work_hash
      }.wont_change 'Work.count'

      must_respond_with :redirect
    end

    it 'does not patch work if the form data violates Work validations' do
      original_category = work.category
      original_title = work.title
      original_creator = work.creator
      original_publication_year = work.publication_year
      original_description = work.description

      expect {
        patch work_path(work.id), params: invalid_work_hash
      }.wont_change 'Work.count'

      work.reload

      expect(work.category).must_equal original_category
      expect(work.title).must_equal original_title
      expect(work.creator).must_equal original_creator
      expect(work.publication_year).must_equal original_publication_year
      expect(work.description).must_equal original_description
    end
  end

  describe 'destroy' do
    it 'destroys work in db when work exists and redirects' do
      work

      expect {
        delete work_path(work.id)
      }.must_change 'Work.count', -1

      must_respond_with :redirect
    end

    it 'does not change the db when work does not exist and redirects' do
      expect {
        delete work_path(-1)
      }.wont_change 'Work.count'

      must_respond_with :redirect
    end
  end
end
