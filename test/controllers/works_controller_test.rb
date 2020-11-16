require "test_helper"

describe WorksController do
  describe 'index' do
    it 'can get the works path' do
      get works_path
      must_respond_with :success
    end
  end

  describe 'new' do
    it 'can get the works path' do
      get new_work_path
      must_respond_with :success
    end
  end
  describe 'show' do
    it 'can get the works path' do
      get works_path
      must_respond_with :success
    end
  end
  # describe 'create' do
  #
  # end
  #
  # describe 'update' do
  #
  # end
  #
  # describe 'destroy' do
  #
  # end
  #
end
