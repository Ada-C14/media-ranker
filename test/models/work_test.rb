require "test_helper"

describe Work do


  describe "validations" do
    it "allows a new work to be created with all the proper fields" do

    end

    it "Won't allow a new work to be created without all required fields" do

    end
  end

  describe "category_filter" do
    it "will return just the works from a particular category" do
      @works = Work.all

      expect {
        @works.category_filter("Book").category
      }.must_equal "Book"

    end
  end

  describe "spotlight" do
    it "will give 10 random works" do

    end
  end
end
