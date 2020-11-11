require "test_helper"

describe WorksController do

  before do
    @work = Work.create!(media: "movie",
                          title: "Frozen",
                          created_by: "Walt Disney",
                          published: 2013,
                          description: "A tale about two Princesses,a snowman & rugged iceman.")
  end

  describe 'index' do

    it "should get the root path" do
      get root_path
      must_respond_with :success
    end

    it "can get to the index page" do
      get works_path

      must_respond_with :success
    end
  end
end


