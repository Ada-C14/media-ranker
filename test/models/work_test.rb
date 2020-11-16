require 'test_helper'

describe Work do

  let (:work) { Work.first }
  let (:work2) { Work.find_by(title: works(:worry).title) }

  it 'can be instantiated with the required fields' do
    expect(work.valid?).must_equal true

    %i[category title creator publication_year description].each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'relationships' do
    it 'can have many votes' do
      expect(work2.votes.count).must_equal 2

      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can have many users through votes' do
      expect(work2.users.count).must_equal 2

      work2.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe 'validations' do
    it 'must have a category field' do
      work.category = nil
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it 'must have a category field that is either a movie, book, or album' do
      work.category = 'video game'
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ['Category must be a movie, book, or album.']
    end

    it 'must have a title' do
      work.title = nil
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'must have a creator' do
      work.creator = nil
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :creator
      expect(work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it 'must have a description' do
      work.description = nil
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :description
      expect(work.errors.messages[:description]).must_equal ["can't be blank"]
    end

    it 'must have a publication year' do
      work.publication_year = nil
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
    end

    it 'must have a publication year from year 1800 through present' do
      work.publication_year = 2030
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ['Please pick a work created from 1800 onward.']

      work.publication_year = 800
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ['Please pick a work created from 1800 onward.']
    end

    it 'must be an integer year' do
      work.publication_year = 2020.1
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ['Please enter an integer value for year, from 1800 onward.']
    end
  end

  describe 'custom methods' do
    it 'Work.media_spotlight: can get the top voted item' do
      expect(Work.media_spotlight).must_equal works(:worry)
    end

    it 'Work.top_ten(category): can get top ten items for each category' do
      60.times do
        Work.create(
          category: %w[album book movie].sample,
          title: 'title',
          creator: 'creator',
          publication_year: 2020,
          description: 'description'
        )
      end

      top_ten_movies = Work.top_ten('movie')
      expect(top_ten_movies.size).must_equal 10

      top_ten_albums = Work.top_ten('album')
      expect(top_ten_albums.size).must_equal 10
      expect(top_ten_albums[0]).must_equal works(:worry)
      expect(top_ten_albums[1]).must_equal works(:ctrl)
    end

    it 'Work.top_ten(category): can get up to 10 items if there are less than 10' do
      top_ten_albums = Work.top_ten('album')
      expect(top_ten_albums.size).must_equal 3
      expect(top_ten_albums[0]).must_equal works(:worry)
      expect(top_ten_albums[1]).must_equal works(:ctrl)
    end
  end
end
