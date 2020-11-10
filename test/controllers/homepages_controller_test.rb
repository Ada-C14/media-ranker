require "test_helper"

describe HomepagesController do
  it 'can route to the homepage' do
    get root_path
    must_respond_with :success
  end
end
