require "test_helper"

describe Work do
  describe "validations" do
    before do
      @spacejam = works(:spacejam)
      @practicalmagic = works(:practicalmagic)
      @lathe = works(:lathe)
    end

  it "requires title field must not be blank" do

    # when creating new entries
    blank_title = Work.new(title: nil, category: "album", creator: "some white guy", publication_year: "2020", description: "some stuff" )
    expect(blank_title.valid?).must_equal false
    expect(blank_title.errors.messages).must_include :title
    expect(blank_title.errors.messages[:title]).must_equal ["can't be blank"]

    # when renaming existing entries
    expect(@spacejam.update(title: nil)).must_equal false
  end

  it "requires title field be unique among its category" do

    # when creating new entries
    dup_movie_title = Work.new(title: "Space Jam", category: "movie", creator: "some white guy", publication_year: "1996", description: "some stuff" )
    expect(dup_movie_title.valid?).must_equal false
    expect(dup_movie_title.errors.messages).must_include :title
    expect(dup_movie_title.errors.messages[:title]).must_equal ["has already been taken"]

    # when renaming existing entries
    expect(@practicalmagic.update(title: "Lathe of Heaven")).must_equal false
  end

  it "allows a duplicate title if it's for a separate category" do

    # when creating new entries
    dup_book_title = Work.new(title: "Space Jam", category: "book", creator: "some white guy", publication_year: "1996", description: "some stuff" )
    expect(dup_book_title.valid?).must_equal true

    # when renaming existing entries
    expect(@spacejam.update(title: "Practical Magic")).must_equal true
  end

  it "rejects invalid categories" do
    invalid_categories = ['banana', 28982, nil]
    invalid_categories.each do |category|
      work = Work.new(title: "test", category: category)
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
    end
  end

  end
end
