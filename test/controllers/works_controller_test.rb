require "test_helper"

describe WorksController do
  before do
    @book = Work.create(category: "Book", title: "Bluebeard", creator: "Kurt Vonnegut", publication_year: 1979, description: "haven't finished this one yet")
    @book2 = Work.create(category: "Book", title: "test book", creator: "me", publication_year: 2020, description: "uninteresting")
    @album = Work.create(category: "Album", title: "Currents", creator: "Tame Impala", publication_year: 2015, description: "Cool songs and stuff")
  end

  describe "homepage" do
    it "routes to the homepage" do
      get root_path

      must_respond_with :success
    end
  end

  describe "index" do
    it "responds with success when accessing index page" do
      get "/works"
      must_respond_with :success
    end

    it "loads all works on index page" do
      get "/works"

      expect(Work.count).must_equal 3
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing work" do
      get "/works/#{@book.id}"

      expect(@book.title).must_equal "Bluebeard"

      must_respond_with :success
    end

    it "gives flash error for an invalid work" do
      invalid_id = -1

      get "/works/#{invalid_id}"

      expect(flash.now[:error]).must_equal "Hmm..we couldn't find a work with that id"
      must_redirect_to root_path
    end
  end

  describe "new" do
    it "can get the new_work_path" do
      get new_work_path

      must_respond_with :success
    end

    it "" do

    end
  end

  describe "create" do
    it "creates a new work with valid parameters and redirects to show page" do
      work_params = {
          work: {
              category: "Album",
              title: "Music",
              creator: "who knows",
              publication_year: 1979,
              description: "elevator music"
          }
      }

      expect {
        post works_path, params: work_params
      }.must_differ "Work.count", 1

      expect(Work.last.title).must_equal "Music"
      expect(Work.last.creator).must_equal "who knows"
      expect(Work.last.publication_year).must_equal 1979
      expect(Work.last.description).must_equal "elevator music"

      must_redirect_to work_path(Work.last.id)
    end

    it "does not create a new work if there is a missing field" do
      invalid_params = {
          work: {
              category: "Album",
              title: nil,
              creator: "Tame Impala",
              publication_year: 2015,
              description: nil
          }
      }

      expect {
        post works_path, params: invalid_params
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "gets the edit page for a valid work" do
      get edit_work_path(@book.id)

      must_respond_with :success
    end

    it "redirects and shows error message for invalid work id" do
      get edit_work_path(-1)

      expect(flash.now[:error]).must_equal "Hmm..we couldn't find a work with that id"
      must_redirect_to works_path
    end
  end

  describe "update" do
    it "accurately updates a work and redirects" do
      edited_params = {
          work: {
              category: "Album",
              title: "Currents",
              creator: "Tame Impala",
              publication_year: 2015,
              description: "3rd studio album"
          }
      }

      expect {
        @edited_album = patch work_path(@album.id), params: edited_params
      }.wont_change "Work.count"

      @album.update(category: "Album", title: "Currents", creator: "Tame Impala", publication_year: 2015, description: "3rd studio album")

      expect(@album.description).must_equal "3rd studio album"

      must_redirect_to work_path(@album.id)
    end
  end

  describe "destroy" do

  end

end
