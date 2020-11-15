require "test_helper"

describe Vote do
  describe "relationship" do

    it "belongs to one user" do
      #TODO: fix
      # # test each entry from votes.yml file:
      # votes.each do |vote|
      #   expect(vote.user).must_be_instance_of User
      #   expect(vote.user).must_equal user
      # end
    end

    it "belongs to one piece of work/media" do
      # test each entry from votes.yml file:
      votes.each do |vote|
        expect(vote.work).must_be_instance_of Work
        #expect(vote.work).must_equal work.name
      end
    end
  end
end
