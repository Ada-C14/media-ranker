require "test_helper"

describe Work do
  let (:work){
    Work.create!(
        category: "album",
        title: "test",
        creator: "testor",
        publication_year: 2020,
        description: "testing")
  }

  describe "validations" do
    it "is invalid without a title" do
      work.title = nil
      result = work.valid?
      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "is invalid with a repeating title and validation is not case sensitive" do
      Work.create!(
          category: "album",
          title: "Testing")
      work.title = "testing"
      result = work.valid?
      expect(result).must_equal false
    end

  end
end
