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

      it "can have many votes" do
        # Arrange & Act
        user1 = users(:john)
        
        work2 = works(:joe_book)
        work3 = works(:blue_album)
        
        vote2 = votes(:user1_work2)
        vote3 = votes(:user1_work3)

        # Assert
        expect(user1.votes.count).must_equal 2
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

      it "can have many works" do
        # Arrange & Act
        user1 = users(:john)
        
        work2 = works(:joe_book)
        work3 = works(:blue_album)
        
        vote2 = votes(:user1_work2)
        vote3 = votes(:user1_work3)

        # Assert
        expect(user1.works.count).must_equal 2
      end
    end  
  end
  
  describe 'custom methods' do
    describe "each_user_votes" do
      it "can count how many votes a user voted" do
        # Arrange & Act
        user1 = users(:john)
        vote2 = votes(:user1_work2)
        vote3 = votes(:user1_work3)

        # Assert
        expect(user1.each_user_votes).must_equal 2
      end

      it "gives zero if a user has zero vote" do
        # Arrange & Act
        user3 = users(:sia)

        # Assert
        expect(user3.each_user_votes).must_equal 0
      end
    end

    describe "order_voted_works" do
      it "lists the works by vote's date in descending order" do
        # Arrange
        user1 = users(:john)
        
        vote1 = votes(:user1_work2)   # vote date 11/8/2020
        vote2 = votes(:user1_work3)   # vote date 11/12/2020

        # Act
        list = user1.order_voted_works

        # Assert
        expect(list.first.id).must_equal vote2.id
      end
    end

    describe "self.index_order" do
      it "lists the users by joined date in descending order" do
        # Arrange
        user1 = users(:john)    # id 1
        user3 = users(:sia)     # id 3

        # Act
        list = User.index_order 

        # Assert
        expect(list.first.id).must_equal user1.id
      end
    end
  end
end
