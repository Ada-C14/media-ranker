require "test_helper"

describe Work do
  #relations: no relations yet

  describe "validations" do
    before do
      @work = Work.new(category: "movie", title: "s", creator: "r", publication_year: "1990", description: "u")
    end

    #validations: all passing
    it "is valid when all fields are present" do
      expect(@work.valid?).must_equal true
    end

    #validations: each missing
    it 'is invalid without a title' do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without a creator' do
      @work.creator= nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator
    end

    it "is invalid if it has the same title as another work in the same category" do
      new_work = Work.new(category: "movie", title: "Clue")
      validity = new_work.valid?

      expect(validity).must_equal false
    end

    #custom methods: none yet
  end
end
