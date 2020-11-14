require "test_helper"

describe Work do
  describe 'validations' do
    it 'is valid when all fields are present' do
      # Act
      work = works(:kreb_album)
      
      # Arrange
      result = work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      # Arrange
      work = works(:kreb_album)
      work.title = nil
    
      # Act
      result = work.valid?
    
      # Assert
      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'is invalid with a non-unique title' do
      # Arrange
      uniq_work = Work.create!(
        category: "book",
        title: "Mitsubachi to Enrai",
        creator: "Blaise Lesch",
        publication_year: 1968,
        description: "Voluptatem adipisci qui velit."
      )
      works(:kreb_album).title = uniq_work.title

      # Act
      result = works(:kreb_album).valid?

      # Assert
      expect(result).must_equal false
      expect(works(:kreb_album).errors.messages).must_include :title
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
        expect(work2.votes.find(vote.id)).must_equal vote
      end
    end

    describe "users" do 
      it "only considers a vote is voted by an user" do
        # Arrange
        user1 = users(:john)
        work1 = works(:kreb_album)

        expect(work1.users.include?(user1)).must_equal false
        # Act
        vote = Vote.create!(user_id: user1.id, work_id: work1.id)
        # Assert
        expect(work1.users.include?(user1)).must_equal true
      end
    end  
  end
end
