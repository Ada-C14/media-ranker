require "test_helper"

describe HomepagesController do
  describe 'index' do
    it 'responds with success when access root path' do
      get root_path
      must_respond_with :success
    end
  end
end
