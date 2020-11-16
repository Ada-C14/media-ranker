require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #
  let (:new_work) {
    Work.new(category: "book", title: "BFG", creator: "Roald Dahl", publication_year: "1982", description: "(short for The Big Friendly Giant)")
  }

  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title, caps does not factor in" do
      new_work.save
      new_work_2 = Work.new(category: "book", title: "BfG", creator: "Roald Dahl", publication_year: "1982", description: "duplicate entry")
      new_work_2.save

      expect(new_work_2.valid?).must_equal false
      expect(new_work_2.errors.messages).must_include :title
      expect(new_work_2.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "can have same title if category different" do
      new_work.save
      new_work_2 = Work.new(category: "album", title: "BFG", creator: "Roald Dahl", publication_year: "1982", description: "duplicate entry")
      new_work_2.save

      expect(new_work_2.valid?).must_equal true
      end
  end

  describe 'relations' do
    it 'has many votes' do
      work = works(:gods)
      vote = Vote.create!(work_id: 1, user_id: 4)

      expect(work.votes.first).must_be_instance_of Vote
      expect(work.votes.count > 1).must_equal true
    end

    it 'has many users through votes' do
      work = works(:gods)
      vote = Vote.create!(work_id: 1, user_id: 4)

      expect(work.users.first).must_be_instance_of User
      expect(work.users.count > 1).must_equal true
    end
  end

end
