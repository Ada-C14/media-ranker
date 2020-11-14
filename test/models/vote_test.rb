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
    user = User.create(
        username: "lalala23"
    )

    @vote = Vote.new(user: user, work: work)
  end

  it 'is valid when user has not voted for the work before' do
    result = @vote.valid?

    expect(result).must_equal true
  end

  it 'is invalid when user has already voted for the work' do

    existing_vote = Vote.create(
        user: User.find_by(username: "lalala23"),
        work: Work.find_by(title: "test work")
    )
    result = @vote.valid?

    expect(result).must_equal false
  end


end
