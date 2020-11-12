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
  it "has all the required fields" do
    new_work.save
    work = Work.first

    [:title, :category, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end

  it 'is valid when all fields are present' do
    new_work.save
    expect(new_work.valid?).must_equal true
  end

  it 'is invalid without a title' do
    # Arrange
    new_work.title = nil

    # Assert
    expect(new_work.valid?).must_equal false
    expect(new_work.errors.messages).must_include :title
  end

  it "is invalid with a non-unique title" do
    # do we need the other fields? I'm going with no
    Work.create!(title: new_work.title)

    expect(new_work.valid?).must_equal false
    expect(new_work.errors.messages).must_include :title
    expect(new_work.errors.messages[:title].include?("already been taken")).must_equal true
  end
end
describe "rerlationships" do

end
