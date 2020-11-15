require "test_helper"

describe VotesController do
  it "must get index" do
    get votes_index_url
    must_respond_with :success
  end

  it "must get show" do
    get votes_show_url
    must_respond_with :success
  end

  it "must get create" do
    get votes_create_url
    must_respond_with :success
  end

  it "must get edit" do
    get votes_edit_url
    must_respond_with :success
  end

  it "must get new" do
    get votes_new_url
    must_respond_with :success
  end

  it "must get destroy" do
    get votes_destroy_url
    must_respond_with :success
  end

  it "must get update" do
    get votes_update_url
    must_respond_with :success
  end

end
