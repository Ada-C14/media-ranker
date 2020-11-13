require "test_helper"

describe Work do

  describe "validation" do
    before do
      @work = Work.new(media:'movie', title: 'Finding Nemo', published: "2003", description: 'A tale of clownfish')
    end

    it "must be valid when all fields are correct" do

      result = @work.valid?

      expect(result).must_equal true
    end

    it "Work will requires a title" do

      @work.title = nil

      valid_work =@work.valid?

      expect(valid_work).must_equal false
    end

    it "Work is invalid without category" do
      @work.media = nil

      invalid_work = @work.valid?

      expect(invalid_work).must_equal false
    end
  end

end
