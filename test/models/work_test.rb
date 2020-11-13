require "test_helper"

describe Work do
  describe "validations" do
    let(:work) {
      Work.new(title: "Sample Work")
    }

    it "is valid when all fields are present" do
      result = work.valid?

      expect(result).must_equal true
    end

    it "is invalid without a title" do
      work.title = nil

      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_include "can't be blank"
    end

    it "is invalid if title already exists" do
      unique_work = Work.create!(title: "Unique Work")
      work.title = unique_work.title

      result = work.valid?

      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_include "has already been taken"
    end
  end

  describe "self.by_category(category)" do

    it "returns list with correct number of works of specific category saved" do
      expected_num_of_albums = Work.where(category: "album").count

      actual_num_of_albums = Work.by_category("album").count

      expect(actual_num_of_albums).must_equal expected_num_of_albums

      Work.by_category("album").each do |album|
        expect(album).must_be_kind_of Work
      end
    end

    it "returns empty collection if no works of specific category saved" do
      all_movies = Work.where(category: "movie")

      all_movies.each do |work|
        work.category = "book"
        work.save
      end

      albums = Work.by_category("album")
      books = Work.by_category("book")
      movies = Work.by_category("movie")

      expect(albums.length).must_be :>, 0
      expect(books.length).must_be :>, 0
      expect(movies).must_be_empty
    end
  end

  describe "self.spotlight" do
    it "will return the work with the most votes" do
      expected_most_votes = works(:dune)

      expect(Work.spotlight).must_equal expected_most_votes
    end

    it "will return 1 work if multiple works have the same number of votes" do
      vote_to_change = votes(:eeyore_spiderman)

      vote_to_change.work = works(:odesza)
      vote_to_change.save

      odesza_votes = works(:odesza).votes.count
      dune_votes = works(:dune).votes.count

      expect(odesza_votes).must_equal dune_votes
      expect(Work.spotlight).must_be_instance_of Work
    end

    it "will return nil if no works are saved" do
      Work.destroy_all

      expect(Work.spotlight).must_be_nil
    end
  end

  describe "self.top_10" do
    it "returns the 10 works with most votes in descending order" do
      expected_first = works(:dune)
      expected_second = works(:odesza)
      expected_third = works(:spiderman)

      expect(Work.top_10.count).must_equal 10
      expect(Work.top_10[0]).must_equal expected_first
      expect(Work.top_10[1]).must_equal expected_second
      expect(Work.top_10[2]).must_equal expected_third
    end

    it "returns all works if less than 10 works saved" do
      Work.where.not(title: "dune").destroy_all

      expect(Work.top_10.count).must_equal Work.all.count
    end

    it "returns nil if there are no works saved" do
      Work.destroy_all

      expect(Work.top_10).must_be_empty
    end
  end
end
