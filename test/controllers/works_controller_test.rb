require "test_helper"

describe WorksController do
  before do
    @work = works(:working_media)
  end
  describe "index" do

    it "must get index " do
      #Action
      get works_path
      #Assert
      must_respond_with :success

    end
  end
    describe "show" do
    it "will get show for a valid id" do
      get work_path(@work.id)
      must_respond_with :success
    end

    it "will give a 404 error for a nonexistent work" do

      get work_path(-1)

      must_respond_with :not_found
    end

    end

    describe "new" do
      it "can get the new_work_path" do
        get new_work_path

        must_respond_with :success
      end
    end
  end




