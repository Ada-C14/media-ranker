require 'test_helper'

describe Work do
  describe 'relations' do
    describe 'votes relations' do
      it 'accepts votes' do
        user = User.create!(username: "Test user")
        work = Work.create!(category: 'movie', title: 'Test movie')
        vote = Vote.create!(user: user, work: work)


        expect(work.votes.include?(vote)).must_equal true
        expect(work.votes.size).must_equal 1
      end

      it 'has many votes' do
        #use fixtures yml data
        work = works(:album4)

        expect(work.votes.count).must_equal 6
      end

      it 'can access users through votes' do
        work = works(:album4)

        expect(work.users.count).must_equal 6

      end
    end
  end

  describe 'validation' do
    before do
      #Arrange: a valid work
      @work = Work.new(category: 'book', title: 'title', publication: 1992, description: 'long description')
    end

    it 'is valid when all fields are present' do
      # Another way to write this:
      #value(@work).must_be :valid?

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is valid without optional fields (publication and description)' do
      @work.publication = nil
      @work.description = nil
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without category' do
      @work.category = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it 'is invalid without title' do
      @work.title = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end

  describe 'top_work_method' do
    it 'returns the top work' do
      # Arrange / Act
      # Top work should be album4 with 6 votes
      # Where would description of my fixtures?  I think I made them too complicated
      spotlight = Work.top_work
      most_votes = works(:album4)


      expect(spotlight.id).must_equal most_votes.id
    end

    it 'return nil if no works' do
      Work.all.each do |work|
        work.destroy
      end

      featured_work = Work.top_work

      expect(featured_work).must_be_nil
    end
  end

  describe 'top_ten method' do
    before do
      @top_albums = Work.top_ten('album')
    end

    # Fixtures:
    # top album is album4 (title: AlbumE) with 6 votes, album3 has 5 votes, album 2 has 4 votes, album[0, 1, 5] has 1 vote, the rest have 0 votes.
    # if tied in votes, should sort by title alphabetical
    it 'gets top ten for more than 10 items' do
      # albums is the category with > 10 items (has 15)
      # top album is album4 (title: AlbumE) with 6 votes

      expect(@top_albums.count).must_equal 10

      # top 3 should be:
      expect(@top_albums.first.title).must_equal 'AlbumE' # yml album4
      expect(@top_albums.first.votes.count).must_equal 6
      expect(@top_albums[1].title).must_equal 'AlbumD' # yml album3
      expect(@top_albums[1].votes.count).must_equal 5
      expect(@top_albums[2].title).must_equal 'AlbumC' # yml album2
      expect(@top_albums[2].votes.count).must_equal 4

      # 10th (last) should be:
      expect(@top_albums.last.title).must_equal 'AlbumJ' # album9 (because albums start at 0)
      expect(@top_albums.last.votes.count).must_equal 0
    end

    it 'will sort alphabetical by title if num votes is tied' do
      # in @top_albums index position 3, 4, have 1 vote, should sort alphabetical, album0 (title: AlbumA), album1 (title: AlbumB), album5 (title: AlbumF)

      expect(@top_albums[3].title).must_equal 'AlbumA' # yml album2
      expect(@top_albums[3].votes.count).must_equal 1

      expect(@top_albums[4].title).must_equal 'AlbumB' # yml album2
      expect(@top_albums[4].votes.count).must_equal 1

    end

    it 'gets top ten for less than 10 items' do
      top_books = Work.top_ten('book')

      expect(top_books.count).must_equal 5
    end

    it 'returns empty array for no items in category' do
      # will return an empty array
      top_movies = Work.top_ten('movies')

      expect(top_movies.empty?).must_equal true
    end

  end

end
