require "test_helper"

describe WorksController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #
  describe "homepage" do
    it "responds with success when there are works saved" do
      # Arrange
      # Ensure that there is at least one work saved

      new_work = Work.new(category: "book", title: "BFG", creator: "Roald Dahl", publication_year: "1982", description: "(short for The Big Friendly Giant)")
      new_work.save

      expect(Work.count).must_equal 4

      # Act
      get root_path

      # Assert
      must_respond_with :success
    end

    # it "responds with success when there are no drivers saved" do
    #   # Arrange
    #   # Doesn't work with yml file
    #   expect(Work.count).must_equal 3
    #
    #   # Act
    #   get root_path
    #
    #   # Assert
    #   must_respond_with :success
    # end
  end
end
