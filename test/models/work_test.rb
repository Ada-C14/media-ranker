require "test_helper"

describe Work do
  before do
    # Arrange
    @work = works(:dead_alive)
  end


  #have 9 works, see if it works with, 9, add one (no votes) , see if it is last
  describe 'relationships' do
    it 'can be added to a vote' do
      expect{
        Vote.create(work: @work, user: users(:me))
      }.must_change "@work.votes.count", 1
    end

    it 'has access to users when added to vote' do
      expect{
        Vote.create(work: @work, user: users(:me))
      }.must_change "@work.users.count", 1
    end
  end

  describe 'validations' do

    it 'is valid when all fields are present and correctly formatted' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it "will be invalid without title" do
      @work.title = nil

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
      expect(@work.errors.messages[:title][0]).must_equal "can't be blank"
    end

    it "will be invalid without category" do
      @work.category = nil

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
      expect(@work.errors.messages[:category][0]).must_equal "can't be blank"
    end

    it "will be valid with blank creator" do
      @work.creator = nil
      expect(@work.valid?).must_equal true
    end

    it "will be valid with blank description" do
      @work.description = nil
      expect(@work.valid?).must_equal true
    end

    it "will be valid with blank publication_date" do
      @work.publication_date = nil
      expect(@work.valid?).must_equal true
    end

    it 'will be invalid with non-int publication_date' do
      @work.publication_date = "date"

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_date
      expect(@work.errors.messages[:publication_date][0]).must_equal "is not a number"
    end

    it 'will be invalid if publication_date is < 0' do
      @work.publication_date = -1984

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_date
      expect(@work.errors.messages[:publication_date][0]).must_equal "must be greater than 0"
    end

    it 'will be invalid if publication_date is > 2100' do
      @work.publication_date = 3000

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_date
      expect(@work.errors.messages[:publication_date][0]).must_equal "must be less than or equal to 2100"
    end
  end

  describe 'custom methods' do

    describe 'top_one' do
      it 'top_one return the work with the most votes' do
        20.times {|i| Vote.create(user: User.new(name: "usr#{i}"), work: @work)}
        expect(Work.top_one.title).must_equal "Dead Alive"
      end

      it 'if there is a tie, top_one returns first in alphabetical order' do
        20.times {|i| Vote.create(user: User.new(name: "usr#{i}"), work: @work)}
        20.times {|i| Vote.create(user: User.new(name: "usr#{i}"), work: works(:aguirre))}
        expect(Work.top_one.title).must_equal "Aguirre, the Wrath of God"
      end

      it 'top_one returns nil when there are no works' do
        Work.delete_all
        expect(Work.top_one).must_be_nil
      end
    end

    describe 'top_ten' do
      it 'top_ten("category")[0] has the most votes' do
        20.times {|i| Vote.create(user: User.new(name: "usr#{i}"), work: @work)}
        expect(Work.top_ten("movie")[0].title).must_equal "Dead Alive"
      end

      it 'top_ten("category")[9] has the least votes out of the ten' do
        works.each{|work| Vote.create(user: users(:me), work: work) unless work.id == 2}

        expect(Work.top_ten("movie")[9].title).must_equal "Aguirre, the Wrath of God"
      end

      it 'will work if number of works is < 10' do
        works.each{|work| work.delete unless(work.id == 2 || work.id == 3)}
        20.times {|i| Vote.create(user: User.new(name: "usr#{i}"), work: works(:aguirre))}
        expect(Work.top_ten("movie")[0].title).must_equal "Aguirre, the Wrath of God"
        expect(Work.top_ten("movie")[1].title).must_equal "Movie A"
      end

      it 'will return empty array if there are no works in category' do
        expect(Work.top_ten("album")).must_equal []
      end

      it 'will return empty array if category doesnt match any works' do
        expect(Work.top_ten("anime")).must_equal []
      end

      it 'will list alphabetically if there is a tie' do
        works.each{|work| Vote.create(user: users(:me), work: work)}

        expect(Work.top_ten("movie")[0].title).must_equal "Aguirre, the Wrath of God"
        expect(Work.top_ten("movie")[9].title).must_equal "Vertigo"
      end
    end
  end
end
