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
  it "is invalid with a non-unique title" do
    # do we need the other fields? I'm going with no
    unique_work = Work.create!(title: new_work.title)

    expect(new_work.valid?).must_equal false
    expect(new_work.errors.messages).must_include :title
    expect(new_work.errors.messages[:title].include?("has already been taken")).must_equal true

  end
end
