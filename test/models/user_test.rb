require "test_helper"

describe User do
 before do
  @new_user = users(:user_one)
  @work_one = works(:work_one)
  @work_two = works(:work_two)
  vote_1 = Vote.create!(user_id: @new_user.id, work_id: @work_one.id)
  vote_2 = Vote.create!(user_id: @new_user.id, work_id: @work_two.id)
 end

  it "can be instantiated" do
    # assert
    expect(@new_user.valid?).must_equal true
  end

  describe "validations" do
    it "is valid when there is a name" do
      # act & assert
      expect(@new_user.valid?).must_equal true
    end

    it "is invalid when there is no name" do
      # arrange
      @new_user.name = nil

      # assert
      expect(@new_user.valid?).must_equal false
      expect(@new_user.errors.messages).must_include :name
      expect(@new_user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # assert
      expect(@new_user.votes.count).must_equal 2
      @new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "can have many works through votes" do
      expect(@new_user.works.count).must_equal 2
      @new_user.works.each do |work|
        expect(work).must_be_instance_of Work 
      end
    end
    
  end

end
