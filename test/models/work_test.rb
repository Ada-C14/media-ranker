require "test_helper"

describe Work do
  before do
    @work = works(:work1)
  end

  describe "validations" do
    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "is invalid with a repeating title and validation is not case sensitive" do
      work2 = works(:work2)
      work2.title = "work1"
      result = work2.valid?
      expect(result).must_equal false
    end

    it "is invalid without a category" do
      @work.category = nil
      result = @work.valid?
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

  end
end
