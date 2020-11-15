require "test_helper"

describe HomepagesController do
  it "responds with success without any works saved" do
    get root_path

    must_respond_with :success
  end
  it "responds with success with works saved" do
    Work.create(category: 'book', title: 'book')

    get root_path

    must_respond_with :success
  end
end
