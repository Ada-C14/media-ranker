require "test_helper"

describe Vote do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  before do

    work = Work.create(
        category: "book",
        title: "test work",
        creator: "test creator",
        publication_year: 2003,
        description: "blah blah"
    )

    work2 = Work.create(
        category: "movie",
        title: "test work2",
        creator: "test creator2",
        publication_year: 2010,
        description: "blah blah blah"
    )
    user = User.create(
        username: "lalala23"
    )

    @vote = Vote.new(user: user, work: work)
    @vote2 = Vote.new(user: user, work: work2)
  end

  it 'is valid when user has not voted for the work before' do

    result = @vote.valid?
    expect(result).must_equal true

  end

  it "user can vote for different works" do
    # save first vote by the user
    @vote.save

    # vote 2 by the same user
    result2 = @vote2.valid?
    expect(result2).must_equal true
  end

  it 'is invalid when user has already voted for the work' do

    existing_vote = Vote.create(
        user: User.find_by(username: "lalala23"),
        work: Work.find_by(title: "test work")
    )
    result = @vote.valid?

    expect(result).must_equal false
    expect(@vote.errors.messages).must_include :work_id
  end


  describe 'relations' do

    it "has a user" do
      vote = votes(:vote1)
      expect(vote.user).must_equal users(:user1)

      expect(vote.user).must_be_instance_of User
    end

    it "has a work" do
      vote = votes(:vote1)
      expect(vote.work).must_equal works(:book1)

      expect(vote.work).must_be_instance_of Work
    end

    it "can set the user" do
      vote = Vote.new
      vote.user = users(:user1)
      expect(vote.user_id).must_equal users(:user1).id
    end

    it "can set the work" do
      vote = Vote.new
      vote.work = works(:book2)
      expect(vote.work_id).must_equal works(:book2).id
    end
  end

end
