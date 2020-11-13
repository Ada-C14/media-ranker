require 'test_helper'

describe WorksController do

  describe 'index' do
   it 'responds with success when there are many works saved' do
     get works_path
     must_respond_with :success
   end
  end


  describe 'show' do

    it 'responds with success when showing an existing valid work' do
      # test each entry in the works.yml file:
      works.each do |work|
        get work_path(work.id)
        must_respond_with :success
      end
    end

    it 'responds with redirect for an invalid work id' do
      get work_path(-1)
      must_respond_with :redirect
      must_redirect_to works_path

    end
  end

  describe 'new' do
    it 'responds with success' do
      get new_work_path
      must_respond_with :success
    end
  end

end
