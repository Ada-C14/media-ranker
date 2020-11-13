require "test_helper"

describe Work do
  before do
    # Arrange
    @work = works(:dead_alive)
  end

  it 'is valid when all fields are present' do
    # Act
    result = @work.valid?

    # Assert
    expect(result).must_equal true
  end


end
