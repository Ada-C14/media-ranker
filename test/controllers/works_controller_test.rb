require "test_helper"

describe WorksController do
  describe "index" do
    it "responds with success " do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success" do
      valid_test_work = works(:work_1)
      get works_path "#{valid_test_work.id}"
      must_respond_with :success
    end
  end

  describe "new" do
    it "responds with success" do
      Work.new(
          {
              title: "Test title"
          }
      )
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    let (:work_hash) {
      {
          work: {
              category: "movie",
              title: "test title",
              creator: "test creator",
              publication_year: "2009",
              description: "test description"
          }
      }
    }
    it "can create a new work" do
      expect {
        post works_path, params: work_hash
      }.must_differ 'Work.count', 1

      saved_work = Work.find_by(title: "test title")
      must_redirect_to work_path(saved_work.id)
      expect(saved_work.category).must_equal work_hash[:work][:category]
      expect(saved_work.title).must_equal work_hash[:work][:title]
      expect(saved_work.creator).must_equal work_hash[:work][:creator]
      expect(saved_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(saved_work.description).must_equal work_hash[:work][:description]
    end

    it "wont create a work if the data is missing" do
      work_hash[:work][:title] = nil
      expect {
        post works_path, params: work_hash
      }.must_differ "Work.count", 0
      must_respond_with :bad_request
    end

    it "wont create a work if the title already exist " do
      work_hash = {
          work:
              {
                  category: "album",
                  title: "Wake-up Pie"
              }
      }

      expect {
        post works_path, params: work_hash
      }.must_differ "Work.count", 0
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "responds with success" do
      work_id = Work.find_by(title: "Bad Moms")
      get works_path "#{work_id}/edit"
      must_respond_with :success
    end
  end

end
