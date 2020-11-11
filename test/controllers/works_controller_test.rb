require "test_helper"

describe WorksController do
  describe "index" do
    it "responds with success when works are saved" do
      work = works(:dune)

      get works_path

      must_respond_with :success
    end

    it "responds with success when no works are saved" do
      Work.destroy_all

      get works_path

      must_respond_with :success
    end
  end

  describe "new" do
    it "responds with success when loading page for a new work" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a work with valid input and redirects" do
      valid_work_hash = {
        work: {
          category: "album",
          title: "In Return",
          creator: "Odesza",
          publication_year: 2014,
          description: "Et et expedita non aut quo."
        }
      }

      expect{
        post works_path, params: valid_work_hash
      }.must_change "Work.count", 1

      created_work = Work.find_by(title: "In Return")

      expect(created_work.category).must_equal valid_work_hash[:work][:category]
      expect(created_work.creator).must_equal valid_work_hash[:work][:creator]
      expect(created_work.publication_year).must_equal valid_work_hash[:work][:publication_year]
      expect(created_work.description).must_equal valid_work_hash[:work][:description]

      must_respond_with :redirect
    end

    it "does not create a work without a title" do
      skip
      invalid_work_hash = {
        work: {
          title: nil
        }
      }

      expect{
        post works_path, params: invalid_work_hash
      }.wont_change "Work.count"

      must_respond_with :render
      assert_template :new
    end
  end

  describe "show" do
    it "responds with success when showing an existing work" do
      work = works(:dune)

      get work_path(work)

      must_respond_with :success
    end

    it "responds with 404 when showing a non-existant work" do
      get work_path(-1)

      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "responds with success when editing an existing work" do
      work = works(:dune)

      get edit_work_path(work)

      must_respond_with :success
    end

    it "responds with 404 when editing a non-existent work" do
      get edit_work_path(-1)

      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:valid_work_hash) {
      {
        work: {
          category: "book",
          title: "updated Dune",
          creator: "updated Frank Herbert",
          publication_year: 2020,
          description: "Updates on updates"
        }
      }
    }

    it "it updates an existing work with valid input and redirects" do
      work = works(:dune)

      expect{
        patch work_path(work), params: valid_work_hash
      }.wont_change "Work.count"

      work.reload

      expect(work.category).must_equal valid_work_hash[:work][:category]
      expect(work.title).must_equal valid_work_hash[:work][:title]
      expect(work.creator).must_equal valid_work_hash[:work][:creator]
      expect(work.publication_year).must_equal valid_work_hash[:work][:publication_year]
      expect(work.description).must_equal valid_work_hash[:work][:description]

      must_respond_with :redirect
    end

    it "does not update a non-existent work and responds with 404 " do
      expect{
        patch work_path(-1), params: valid_work_hash
      }.wont_change "Work.count"

      must_respond_with :not_found
    end

    it "does not update an existing work if form data violates Work validations" do
      skip
      work = work(:dune)
      title = work.title

      invalid_hash = {
        work: {
          title: nil
        }
      }

      expect {
        patch work_path(work), params: invalid_hash
      }.wont_change "Work.count"

      work.reload

      expect(work.title).must_equal title

      must_respond_with :render
      assert_template :edit
    end
  end

  describe "destroy" do
    it "destroys an existing work and redirects" do
      work = works(:dune)

      expect {
        delete work_path(work)
      }.must_change "Work.count", -1

      must_respond_with :redirect
    end

    it "does not change the database if work does not exist, and responds with 404" do
      expect {
        delete work_path(-1)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end
end
