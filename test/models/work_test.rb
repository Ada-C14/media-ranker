require 'test_helper'

describe Work do
  let (:new_work) {
    work.new(title: "Kari", description: "123", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = work.first
    [:title, :description, :available].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end
end
