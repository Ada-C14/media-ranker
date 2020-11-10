require "test_helper"

describe Work do

  let (:work) {
    Work.create(
        category: 'album',
        title: 'ctrl',
        creator: 'sza',
        publication_year: 2017,
        description: 'Top Dawg Entertainment and RCA Records'
    )
  }

  it 'can be instantiated with the required fields' do
    expect(work.valid?).must_equal true

    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'relationships' do

  end

  describe 'validations' do

  end

  describe 'custom methods' do

    it 'Work.media_spotlight: can get the top voted item' do

    end

    it 'Work.media_spotlight: responds with success hmmm idk' do

    end

    it 'Work.top_ten(category): can get top ten items for each category' do

    end

    it 'Work.top_ten(category): can get up to 10 items if there are less than 10' do

    end

  end
end
