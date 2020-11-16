require 'test_helper'
require 'pry'

describe Work do
  let(:new_work) {
    Work.new(media: "movie", title: "coco", created_by: "Disney", published: "2017", description: "a tale of dia de los muertos")
  }

  it "can be instantiated" do  #Passing
    expect(new_work.valid?).must_equal true
  end

  describe "validation" do
    before do
      @work = Work.create(media:"movie", title: "The Little Mermaid", created_by: "Walt Disney Studios", published: "1989", description: "A mermaid princess makes a bargain to become human and win a prince's love.")
    end

    it "must be valid when all fields are correct" do  #PASSING
      result = @work.valid?
      expect(result).must_equal true
    end

    it "is invalid without a title" do  #PASSING
      @work.title = nil
      valid_work =@work.valid?
      expect(valid_work).must_equal false
    end

    it "is invalid without category" do  #PASSING
      @work.media = nil
      invalid_work = @work.valid?
      expect(invalid_work).must_equal false
    end

    it "is valid entry without filling out description and publication" do  # PASSING

      @work.published = nil
      @work.description = nil
      result = @work.valid?
      expect(result).must_equal true
    end

    it "it's valid when title is unique" do  #PASSING

      movie1 = Work.create(media: "movie", title: "The Little Mermaid", created_by: "Walt Disney Studios", published: "1989", description: "A mermaid princess makes a bargain to become human and win a prince's love.")
      results1 = movie1.valid?
      expect(results1).must_equal false
    end
  end

  describe "spotlight" do

    it "will select the top media with highest votes" do

      spotlight = Work.spotlight
      expect(spotlight).must_be_kind_of Work
      #FIXTURES --> not sure I am using them correctly?
      # user = User.find_by(username: "user1")
      # work = Work.find_by(title: "finding nemo")
    end

    it "will return nil if there are no works" do  #Passing

      Work.destroy_all
      spotlight = Work.spotlight
      expect(spotlight).must_equal nil
    end
  end

  describe "relationships" do
    it "can  have many votes" do
      work = works(:album1)
      expect(work.votes.count).must_equal 5
    end
  end

  describe "top ten works " do

    it "will provide us with the top 10 of media category" do  #Passing
      results = Work.top_ten('album')
      expect(results.length).must_equal 10
    end
  end
end
