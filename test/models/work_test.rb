require "test_helper"

describe Work do
    it "can be instantiated" do
      # Assert
      expect(works(:book).valid?).must_equal true
    end
end
