require "test_helper"

describe Work do
  describe "validations" do
    before do
      @work = Work.new(category: "book", title: "Death on the Nile", creator: "Agatha Christie", publication_year: 1937, description: "Hercule Poirot is not allowed to take a vacation")
    end

    it "creates a work when given valid data" do
      success = @work.valid?

      expect(success).must_equal true
    end

    it "won't create a work without a title" do
      @work.title = nil

      success = @work.valid?

      expect(success).must_equal false
    end

    it "won't create a work with a duplicate title" do
      @work.save
      @second_work = Work.new(category: "album", title: "Death on the Nile")

      success = @second_work.valid?

      expect(success).must_equal false
    end

    it "only accepts integers for publication years" do
      @work.publication_year = "The Thirties"

      success = @work.valid?

      expect(success).must_equal false
    end

    it "will not create a work with an invalid category" do
      @work.category = "TV Show"

      success = @work.valid?

      expect(success).must_equal false
    end
  end

  # describe "relationships" do
  #
  # end
end
