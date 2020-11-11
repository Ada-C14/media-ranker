require "test_helper"

describe WorksController do
  describe "index" do
    it "can get index" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get show page" do
      # use book from fixtures
      get work_path(works(:hp1))
      must_respond_with :success
    end

    it "redirects to index with message if work doesn't exist" do
      get work_path(-1)
      must_respond_with :redirect
      expect(flash[:error]).wont_be_nil
    end
  end

  describe "new" do

  end

  describe "create" do

  end

  describe "edit" do

  end

  describe "update" do

  end

  describe "destroy" do

  end
end
