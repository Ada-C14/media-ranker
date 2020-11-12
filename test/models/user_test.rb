require "test_helper"

describe User do
  let(:new_user) {
    User.new(username: "test user")
  }
  describe "relationships" do
    before do
      new_user.save
      @work_1 = Work.create(category: "book", title: "test title", creator: "test creator", publication_year: 2020, description: "test description")
      @work_2 = Work.create(category: "album", title: "test title", creator: "test creator", publication_year: 2020, description: "test description")

      Vote.create(user_id: new_user.id, work_id: @work_1.id)
      Vote.create(user_id: new_user.id, work_id: @work_2.id)
    end

    it "can have many votes" do
      expect(new_user.votes.count).must_equal 2

      new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "can have many works through votes" do
      expect(new_user.works.count).must_equal 2

      expect(new_user.works.first).must_equal @work_1
      expect(new_user.works.last).must_equal @work_2

      new_user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end
end
