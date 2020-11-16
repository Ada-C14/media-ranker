require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  before do
    work_test = Work.new(title: 'test name')
    @work = Work.new(title: "Mean Girls", description: "high school comedy",
                     publication_date: "2003",
                     creator: "Tina Fey",
                     category: "movie")
  end
  describe 'validations' do
    # before do
    # work_test = Work.new(title: 'test name')
    # @work = Work.new(title: "Mean Girls", description: "high school comedy",
    #                  publication_date: "2003",
    #                  creator: "Tina Fey",
    #                  category: "movie")
    # end
    it "is valid when all fields are filled" do
          result = @work.valid?

          expect(result).must_equal true
    end

    it "fails validation when there is no title" do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages.include?(:title)).must_equal true
      expect(@work.errors.messages[:title].include?("can't be blank")).must_equal true
    end

    it "fails validation when the title already exists" do
      @work.save
      duplicate = Work.create(title: @work.title, description: "high school comedy",
                  publication_date: "2003",
                  creator: "Tina Fey",
                  category: "movie" )

      expect(duplicate.valid?).must_equal false
      expect(duplicate.errors.messages.include?(:title)).must_equal true
      expect(duplicate.errors.messages[:title].include?("has already been taken")).must_equal true
    end
  end

  describe 'relationships' do
    it 'can find the users that voted for a work through a vote instance' do
      @work.save
      user = User.create(name: "test name")
      vote = Vote.new(work_id: @work.id, user_id: user.id)

      vote_user = User.find_by(id: vote.user_id)
      expect(vote_user.name).must_equal user.name
    end
    it 'can find the users of a work' do
      @work.save
      user = User.create(name: "test name")
      vote = Vote.new(work_id: @work.id, user_id: user.id)
      vote.save
      @work.users
    end
    it 'can find the votes of a user' do
      @work.save
      user = User.create(name: "test name")
      vote = Vote.new(work_id: @work.id, user_id: user.id)

      user.votes
      expect(vote.work_id).must_equal @work.id
      expect(vote.user_id).must_equal user.id

      @work.votes.each do |vote|
        unless vote == nil
        expect(vote).must_be_instance_of Vote
        end
      end
    end
    it 'can find the votes of a work' do
      @work.save
      user = User.create(name: "test name")
      vote = Vote.new(work_id: @work.id, user_id: user.id)
      vote.save
      @work.votes
      expect(vote.work_id).must_equal @work.id
      expect(vote.user_id).must_equal user.id

      @work.votes.each do |vote|
        unless vote == nil
          expect(vote).must_be_instance_of Vote
        end
      end
    end
  end

  describe 'spotlight' do
    it 'returns the work with the most votes' do
      works = Work.all

      expect((works.spotlight).title).must_equal "Kreb-Full-o Been"
      expect((works.spotlight).creator).must_equal "Ms. Trevion Buckridge"
    end

    it 'if there is a tie it uses the oldest work' do
      works = Work.all
      recent_work = Work.create(title: "New Work Title",
                                description: "Fugit d est quam sunt porro vel rerum.",
                                publication_date: "1997",
                                creator: "Queen Sattdserfield",
                                category: "album")
      user1 = User.create(name: "test name 1")
      user2= User.create(name: "test name 2")
      user3 = User.create(name: "test name 3")


      vote1 = Vote.create(work_id: recent_work.id, user_id: user1.id)
      vote2 = Vote.create(work_id: recent_work.id, user_id: user2.id)
      # vote3 = Vote.create(work_id: recent_work.id, user_id: user3.id)
      works = Work.all
      pp works.last

      expect((works.spotlight).title).must_equal "Kreb-Full-o Been"
    end
  end
  describe 'top ten' do
    it 'will rank the work from most votes to least votes' do
      # works = Work.all
      expect((Work.top_ten(category: "album")).first.title).must_equal "Kreb-Full-o Been"
      # expect((works.top_ten(category: "album")).last.title).must_equal "Major Cup"

    end

    it 'will rank the work from most votes to least votes' do
      # works = Work.all
      # expect((Work.top_ten(category: "album")).first.title).must_equal "Kreb-Full-o Been"
      expect((Work.top_ten(category: "album")).last.title).must_equal "Holiday Choice"
    end
  end
  describe 'total list' do
    it 'will rank the work from most votes to least votes' do
      # works = Work.all
      expect((Work.total_lists(category: "album")).first.title).must_equal "Kreb-Full-o Been"
      # expect((works.top_ten(category: "album")).last.title).must_equal "Major Cup"

    end

    it 'will rank the work from most votes to least votes' do
      # works = Work.all
      # expect((Work.top_ten(category: "album")).first.title).must_equal "Kreb-Full-o Been"
      expect((Work.total_lists(category: "album")).last.title).must_equal "Holiday Choice"
    end
  end
end
