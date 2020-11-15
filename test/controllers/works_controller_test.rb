require "test_helper"

describe WorksController do
  it "must get index" do
    get "/works"
    must_respond_with :success
  end

end
