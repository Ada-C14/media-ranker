require "test_helper"

describe Work do
  it "can be instantiated" do
    # Assert
    expect(works(:book).valid?).must_equal true
  end

  it "has required fields" do
    work = Work.first
    expect(work).must_respond_to :category
    expect(work).must_respond_to :title
  end

  describe "validations" do
    it "must have a title" do
      works(:book).title = nil

      expect(works(:book).valid?).must_equal false
      expect(works(:book).errors.messages).must_include :title
      expect(works(:book).errors.messages[:title]).must_equal ["can't be blank"]
    end

  end
end
