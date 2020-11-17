require "test_helper"

describe WorksController do

  describe "index" do
    it "can get the index path" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do

    it "can get a valid works" do
      @work = Work.create(category: "book", title: "Work 1", creator: "Creator 1", publication_year: "2020", description: "Description 1")
      work_id = @work.id
      get work_path(work_id)
      must_respond_with :success
    end

    it "will respond with not_found for an invalid works" do
      get work_path(-1)
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new works page" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do

    before do

      @valid_hash = {
          work: {category: "album", title: "Work 2", creator: "Creator 2", publication_year: "2020", description: "Description 2"}
      }

      @invalid_hash_1 = {
          work: {category: nil, title: "Work 1", creator: "Creator 1", publication_year: "2020", description: "Description 1"}
      }

      @invalid_hash_2 = {
          work: {category: "book", title: nil, creator: "Creator 1", publication_year: "2020", description: "Description 1"}
      }

      @invalid_hash_3 = {
          work: {category: "book", title: "Work 1", creator: nil, publication_year: "2020", description: "Description 1"}
      }

      @invalid_hash_4 = {
          work: {category: "book", title: "Work 1", creator: "Creator 1", publication_year: nil, description: "Description 1"}
      }
      @invalid_hash_5 = {
          work: {category: "book", title: "Work 1", creator: "Creator 1", publication_year: "2020", description: nil}
      }

    end

    it "creates a new works" do
      expect {
        post works_path, params: @valid_hash
      }.must_differ "Work.count", 1

      must_respond_with :redirect
      expect(Work.last.category).must_equal @valid_hash[:work][:category]
      expect(Work.last.title).must_equal @valid_hash[:work][:title]
      expect(Work.last.creator).must_equal @valid_hash[:work][:creator]
      expect(Work.last.publication_year).must_equal @valid_hash[:work][:publication_year]
      expect(Work.last.description).must_equal @valid_hash[:work][:description]
    end

    it "requires a category to create a works, does not create works otherwise, and responds with redirect if no title is entered" do
      expect {
        post works_path, params: @invalid_hash_1
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end

    it "requires a title to create a works, does not create works otherwise, and responds with redirect if no title is entered" do
      expect {
        post works_path, params: @invalid_hash_2
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end

    it "requires a creator to create a works, does not create works otherwise, and responds with redirect if no title is entered" do
      expect {
        post works_path, params: @invalid_hash_3
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end

    it "requires a publication_year to create a works, does not create works otherwise, and responds with redirect if no title is entered" do
      expect {
        post works_path, params: @invalid_hash_4
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end

    it "requires a description to create a works, does not create works otherwise, and responds with redirect if no title is entered" do
      expect {
        post works_path, params: @invalid_hash_5
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end

  end

  describe "edit" do

    before do
      @work = Work.create(category: "book", title: "Work 1", creator: "Creator 1", publication_year: "2020", description: "Description 1")
    end

    it "can get the edit page for an existing works" do
      get edit_work_path(@work.id)
      must_respond_with :success
    end

    it "will respond with not_found when attempting to edit a nonexistant works" do
      get edit_work_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do

    before do
      @work = Work.create(category: "book", title: "Work 1", creator: "Creator 1", publication_year: "2020", description: "Description 1")

      @work_hash_6 = {
          work: {category: "book", title: "Work 6", creator: "Creator 6", publication_year: "2020", description: "Description 6"}
      }
    end

    it "can update an existing works" do
      expect {
        patch work_path(@work.id), params: @work_hash_6
      }.must_differ 'Work.count', 0

      must_redirect_to works_path

      updated_work = Work.find(@work.id)
      expect(updated_work.category).must_equal @work_hash_6[:work][:category]
      expect(updated_work.title).must_equal @work_hash_6[:work][:title]
      expect(updated_work.creator).must_equal @work_hash_6[:work][:creator]
      expect(updated_work.publication_year).must_equal @work_hash_6[:work][:publication_year]
      expect(updated_work.description).must_equal @work_hash_6[:work][:description]
    end

    it "will respond with not_found if given an invalid id" do
      expect {
        patch work_path(-1), params: @work_hash_6
      }.must_differ 'Work.count', 0

      must_respond_with :not_found
    end

  end

  describe "destroy" do

    it "can destroy a works" do
      @work7 = Work.create!(category: "book", title: "Work 7", creator: "Creator 7", publication_year: "2020", description: "Description 7")
      # @work7.save
      id = @work7.id

      expect {
        delete work_path(id)
      }.must_change 'Work.count', -1

      work7 = Work.find_by(title: "Work 7")
      expect(work7).must_be_nil

      must_redirect_to works_path
    end

    it "will respond with not_found for invalid ids" do
      expect {
        delete work_path(-1)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end
end
