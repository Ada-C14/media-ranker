require "test_helper"

describe User do
  describe 'validations' do
    it 'is valid when all fields are present' do
      # Arrange
      user = users(:john)

      # Act
      result = user.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a username' do
      # Arrange
      user = users(:john)
      user.username = nil
    
      # Act
      result = user.valid?
    
      # Assert
      expect(result).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it 'is invalid with a non-unique username' do
      # Arrange
      unique_user = User.create!(username: 'Registered user', joined: "Nov 13, 2020")
      users(:john).username = unique_user.username

      # Act
      result = users(:john).valid?

      # Assert
      expect(result).must_equal false
      expect(users(:john).errors.messages).must_include :username
    end
  end

  describe 'relations' do
    describe "votes" do
      it "can set the vote using a Vote" do
        # Arrange & Act
        user1 = users(:john)
        work2 = works(:joe_book)
        vote = votes(:user1_work2)

        # Assert
        expect(user1.votes.find(vote.id)).must_equal vote
      end
    end

    describe "works" do 
      it "only considers a vote added to a work when we have voted it" do
        # Arrange
        user1 = users(:john)
        work1 = works(:kreb_album)

        expect(user1.works.include?(work1)).must_equal false
        # Act
        vote = Vote.create!(user_id: user1.id, work_id: work1.id)
        # Assert
        expect(user1.works.include?(work1)).must_equal true
      end
    end  
  end

end
