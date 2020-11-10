require "test_helper"

describe WorksController do
  it "must get index" do
    get works_index_url
    must_respond_with :success
  end

end
