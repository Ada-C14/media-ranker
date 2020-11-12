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
      expect(@work.errors.messages.include?(:title)).must_equal true
      expect(@work.errors.messages[:title].include?("can't be blank")).must_equal true
    end

    it "fails validation when the title already exists" do
      @work.save
      duplicate = Work.create(title: @work.title, description: "high school comedy",
                  publication_date: "2003",
                  creator: "Tina Fey",
                  category: "movie" )

      expect(duplicate.valid?).must_equal false
      expect(duplicate.errors.messages.include?(:title)).must_equal true
      expect(duplicate.errors.messages[:title].include?("has already been taken")).must_equal true
    end
  end
end
