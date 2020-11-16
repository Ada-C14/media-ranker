require "test_helper"

describe Vote do
  it "can be created with accurate attributes" do
    work2 = Work.create(category: "book", title: "test book3", creator: "test3", publication_year: 2012, description: "test3")
    user = User.create(username: "test2")
    Vote.create(work_id: work2[:id],user_id: user[:id])


    expect(work2.votes.count).must_equal 1
  end
end
