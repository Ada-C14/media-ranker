require "test_helper"

describe WorksController do

  describe "root" do
    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe "index" do
    it "must get index" do
      get works_url
      must_respond_with :success
    end

    it "doesnt break when movies, albums, or books are nil" do
      skip
      # idk how to test this
    end
  end

  describe "show" do
    before do
      @work = Work.create!(
        category: "album",
        title: "test",
        creator: "The Testor",
        publication_year: 2020,
        description: "We love a good test")
    end

    let (:bad_url){
      -99999
    }

    it "must get show" do
      get works_url(@work.id)
      must_respond_with :success
    end

    it "redirects to error page for invalid work" do
      skip
      get works_url(bad_url)
      # must redirect somewhereeeeee
    end
  end

end
