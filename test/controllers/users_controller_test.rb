require "test_helper"

describe UsersController do
  it "must get index" do
    get users_index_url
    must_respond_with :success
  end

end
