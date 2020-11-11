require 'test_helper'

describe WorksController do
  it 'index' do
    get works_path
    must_respond_with :success
  end

  it 'show' do
    get work_path
    must_respond_with :success
  end

  it 'new' do
    get new_work_path
    must_respond_with :success
  end

end
