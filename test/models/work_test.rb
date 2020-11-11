require "test_helper"

describe Work do
  let(:new_work) {
    Work.new(
        category: "album",
        title: "test title",
        creator: "test creator",
        publication_year: "2020",
        description: "test description"
    )
  }
  it 'is valid when all fields are present' do
    # Act
    result = @work.valid?

    # Assert
    expect(result).must_equal true
  end

  it 'is invalid without a title' do
    # Arrange
    @work.title = nil

    # Act
    result = @work.valid?

    # Assert
    expect(result).must_equal false
    expect(@work.errors.messages).must_include :title
  end
end
