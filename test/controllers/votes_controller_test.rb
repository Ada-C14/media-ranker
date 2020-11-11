require "test_helper"

describe VotesController do
  it "must get index" do
    get votes_index_url
    must_respond_with :success
  end

  it "must get new" do
    get votes_new_url
    must_respond_with :success
  end

  it "must get create" do
    get votes_create_url
    must_respond_with :success
  end

end
