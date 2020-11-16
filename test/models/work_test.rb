require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(
        category: "movie",
        title: "An Adie is Sleepy",
        creator: "Ada Wizards",
        publication_year: "2020",
        description: "I would like to go to sleep now."
    )
  }
  it "can be instantiated" do
    expect(:new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    :new_work.save
    Work = Work.first
    Work_fields = [:category, :title, :creator, :publication_year, :description]
    Work_fields.each do |field|

      # Assert
      expect(Work).must_respond_to field
    end
  end



  describe "validations" do

    it "must have a category" do
      :new_work.category = nil
      expect(:new_work.valid?).must_equal false
    end

    it "must have a title" do
      :new_work.title= nil
      expect(:new_work.valid?).must_equal false
    end

    it "must have a creator" do
      :new_work.creator = nil
      expect(:new_work.valid?).must_equal false
    end

    it "must have a publication year" do
      :new_work.publication_year = nil
      expect(:new_work.valid?).must_equal false
    end

    it "must have a description" do
      :new_work.description = nil
      expect(:new_work.valid?).must_equal false
    end

  end

  describe "custom methods" do
    # Write tests here
  end

