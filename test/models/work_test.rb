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

      it "can have many votes" do
        # Arrange & Act
        user1 = users(:john)
        user2 = users(:adele)
        
        work2 = works(:joe_book)

        vote1 = votes(:user1_work2)
        vote2= votes(:user2_work2)

        # Assert
        expect(work2.votes.count).must_equal 2
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

      it "can have many users" do
        # Arrange & Act
        user1 = users(:john)
        user2 = users(:adele)
        
        work2 = works(:joe_book)
        
        vote1 = votes(:user1_work2)
        vote2 = votes(:user2_work2)

        # Assert
        expect(work2.users.count).must_equal 2
      end
    end  
  end

  describe 'custom methods' do
    describe "total_votes" do
      it "can count how many votes a work has" do
        # Arrange & Act
        work2 = works(:joe_book)

        vote2 = votes(:user1_work2)
        vote3 = votes(:user2_work2)

        # Act
        count = work2.total_votes

        # Assert
        expect(count).must_equal 2
      end

      it "gives zero if a work gets zero vote" do
        # Arrange & Act
        work1 = works(:kreb_album)

        # Assert
        expect(work1.total_votes).must_equal 0
      end
    end

    describe "self.index_order" do
      it "lists works by vote counts in descending order" do
        # Arrange
        # album
        work1 = works(:kreb_album)  # vote 0
        work3 = works(:blue_album)  # vote 1

        vote1 = votes(:user1_work3)

        # Act
        list = Work.index_order("album")
        first_on_list = Work.top_ten_helper(list.first[0])

        # Assert
        expect(first_on_list.id).must_equal work3.id
      end

      it "lists works tie in the number of votes by updated_at in descending order" do
        # Arrange
        work1 = works(:kreb_album)     # vote 0, updated at Nov 12, 2020
        work4 = works(:express_album)  # vote 0, updated at Nov 13, 2020

        # Act
        list = Work.index_order("album").to_a
        last_on_list = Work.top_ten_helper(list.last[0])

        # Assert
        expect(last_on_list.id).must_equal work1.id
      end
    end

    describe "self.spotlight" do
      it "can first list works by vote count in descending order" do
        # Arrange
        work2 = works(:joe_book)    # vote 2
        work3 = works(:blue_album)  # vote 1

        # Act
        list = Work.spotlight
        spotlight = Work.top_ten_helper(list[0])

        # Assert
        expect(spotlight.id).must_equal work2.id
      end

      it "lists works tie by created_at in descending order" do
        # Arrange
        work2 = works(:joe_book)    # vote 2
        work3 = works(:blue_album)  # vote 1
        Work.destroy(work2.id)
        Work.destroy(work3.id)
        work13 = works(:book10)     # vote 0, created at Nov 22, 2020
        work14 = works(:book11)     # vote 0, created at Nov 30, 2020

        # Act
        list = Work.spotlight
        spotlight = Work.top_ten_helper(list[0])

        # Assert
        expect(spotlight.id).must_equal work14.id
      end
    end

    describe "self.top_ten" do
      it "can first list works by vote count in descending order" do
        # Arrange
        # album
        work1 = works(:kreb_album)     # vote 0
        work3 = works(:blue_album)     # vote 1
        work4 = works(:express_album)  # vote 0

        # Act
        list = Work.top_ten("album")
        top_one = Work.top_ten_helper(list.first[0])

        # Assert
        expect(top_one.id).must_equal work3.id
      end

      it "lists works tie by created_at in descending order" do
        # Arrange
        # album
        work3 = works(:blue_album)     # vote 1
        Work.destroy(work3.id)
        work1 = works(:kreb_album)     # vote 0, created at Nov 12, 2020
        work4 = works(:express_album)  # vote 0, created at Nov 13, 2020

        # Act
        list = Work.top_ten("album")
        top_one = Work.top_ten_helper(list.first[0])

        # Assert
        expect(top_one.id).must_equal work4.id
      end

      it "can only list 10 works at most" do
        # Arrange & Act
        total_books = Work.where(category: "book")
        list = Work.top_ten("book")

        # Assert
        expect(total_books.count).must_equal 11
        expect(list.count).must_equal 10
      end
    end

    describe "self.top_ten_helper" do
      it "can return a Work" do
        # Arrange & Act
          work1 = works(:kreb_album)
          covert_to_work = Work.top_ten_helper(1)

        # Assert
        expect(covert_to_work).must_be_instance_of Work
        expect(covert_to_work.id).must_equal work1.id
      end
    end
  end
end
