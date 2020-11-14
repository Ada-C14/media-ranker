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
  #have 9 works, see if it works with, 9, add one (no votes) , see if it is last

end
