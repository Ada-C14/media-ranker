require "test_helper"

# Add Relations Tests in Wave 2
# Add Fixtures Later
# New? Create?

describe Work do
  it "is valid when all required fields are present" do
    # Arrange
    @work = Work.new(title: "Long", category: "Movie")

    # Act
    created_work = @work.valid?

    # Assert
    expect(created_work).must_equal true
  end

  it "is invalid without title" do
    # Arrange
    @work = Work.new(category: "Movie")

    #Act
    created_work = @work.valid?

    # Assert
    expect(created_work).must_equal false
    expect(@work.errors.messages).must_include :title
  end

  it "is invalid without category" do
    # Arrange
    @work = Work.new(title: "Long")

    #Act
    created_work = @work.valid?

    # Assert
    expect(created_work).must_equal false
    expect(@work.errors.messages).must_include :category
  end
end
