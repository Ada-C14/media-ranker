require "test_helper"

describe Work do
  let(:new_work){
    Work.new(title: 'New Work', category: 'album')
  }

  describe 'Relationships' do
    it 'can have many votes' do
      new_work.save
      user1 = User.create(username: 'first_user')
      user2 = User.create(username: 'second_user')
      vote1 = Vote.create(user_id: user1.id, work_id: new_work.id)
      vote2 = Vote.create(user_id:user2.id, work_id: new_work.id)

      expect(new_work.votes.count).must_equal 2
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can have many users through votes' do
      new_work.save
      user1 = User.create(username: 'first_user')
      user2 = User.create(username: 'second_user')
      vote1 = Vote.create(user_id: user1.id, work_id: new_work.id)
      vote2 = Vote.create(user_id:user2.id, work_id: new_work.id)

      expect(new_work.users.count).must_equal 2
      new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

  describe 'Validations' do
    before do
    @work = new_work
    end

    it 'is valid when all fields are filled' do
      result = @work.valid?

      expect(result).must_equal true
    end

    it 'fails validation when there is no title' do
      @work.title = nil

      expect(@work.valid?).must_equal false
    end

    it 'fails validation when there is no category' do
      @work.category = nil

      expect(@work.valid?).must_equal false
    end

    it 'fails validation when title already exists' do
      Work.create(title: @work.title, category: @work.category)

      expect(@work.valid?).must_equal false
    end
  end
end
