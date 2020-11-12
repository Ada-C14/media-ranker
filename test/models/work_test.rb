require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe 'validations' do
    before do
    work_test = Work.new(title: 'test name')
    @work = Work.new(title: "Mean Girls", description: "high school comedy",
                     publication_date: "2003",
                     creator: "Tina Fey",
                     category: "movie")
    end
    it "is valid when all fields are filled" do
          result = @work.valid?

          expect(result).must_equal true
    end

    it "fails validation when there is no title" do
      @work.title = nil
      expect(@work.valid?).must_equal false
    end
  end
end
