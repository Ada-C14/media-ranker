require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  let (:new_work) {
    Work.new(title: "Testing title",
             creator: "Testing creator",
             category: "album",
             publication_year: 2020,
             description: "testing description")
    # TODO: check if works.yml would work here?
    # works(:undocumented)
  }

  it "responds to the fields" do
    new_work.save
    work = Work.first

    [:title, :category, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end
  describe "validations" do
    # before do
    #   @work = Work.new(category: "book",
    #                    title: "test title",
    #                    creator: "test creator",
    #                    publication_year: 2020,
    #                    description: "test description"
    #   )
    # end
    it "is valid when all fields are present" do
      new_work.save
      expect(new_work.valid?).must_equal true
    end

    it "is invalid w/o a title" do
      new_work.title = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages.include?(:title)).must_equal true
      expect(new_work.errors.messages[:title].include?("can't be blank")).must_equal true
    end

    it "is invalid if the title already exists" do
      # do we need the other fields? I'm going with no
      Work.create(title: new_work.title)

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title].include?("has already been taken")).must_equal true

    end

  end

  describe "relations" do
    before do
      new_work.save
      new_user = users(:miso)
      second_user = users(:tram)

      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: second_user.id, work_id: new_work.id)
    end
    it "can have many votes" do
      # Assert
      expect(new_work.votes.count).must_equal 2

      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end

    end

    it "can have many users through votes" do

      expect(new_work.users.count).must_equal 2

      new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end

    end
  end

  describe "custom methods" do
    # TODO: not sure how I'd test for random?
    describe "spotlight" do
      before do
        @work_1 = Work.create(category: "book",
                    title: "test title",
                    creator: "test creator",
                    publication_year: 2020,
                    description: "test description"
        )

        @work_2 = Work.create(category: "book",
                    title: "test title 2 ",
                    creator: "test creator 2 ",
                    publication_year: 2019,
                    description: "test description 2"
        )
      end

      it "returns a random work" do
        # arrange
        sample_work = Work.spotlight
        # act
        # assert
        expect(sample_work).must_be_instance_of Work
        expect(sample_work.title).wont_be_nil
      end
    end

    describe "works_in_category" do

    end

    describe "top ten" do

    end

  end
end
