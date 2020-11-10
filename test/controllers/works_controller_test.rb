require "test_helper"

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

  end

  describe 'new' do

  end

  describe 'create' do

  end

  describe 'edit' do

  end

  describe 'update' do

  end

  describe 'destroy' do

  end
end
