require "test_helper"

describe Work do

  describe "validation" do
    before do
      @work = Work.create(media:"movie", title: "The Little Mermaid", created_by: "Walt Disney Studios", published: "1989", description: "A mermaid princess makes a Faustian bargain in an attempt to become human and win a prince's love.")
    end

    it "must be valid when all fields are correct" do

      result = @work.valid?

      expect(result).must_equal true
    end

    it "is invalid without a title" do

      @work.title = nil

      valid_work =@work.valid?

      expect(valid_work).must_equal false
    end

    it "is invalid without category" do
      @work.media = nil

      invalid_work = @work.valid?

      expect(invalid_work).must_equal false
    end

    it "it's valid when title is unique" do

      movie1 = Work.create(media: "movie", title: "The Little Mermaid", created_by: "Walt Disney Studios", published: "1989", description: "A mermaid princess makes a Faustian bargain in an attempt to become human and win a prince's love.")
      # movie2 = Work.create(media: "movie", title: "Aladdin", created_by: "Walt Disney Studios", published: "1992", description: "A kindhearted street urchin and a power-hungry Grand Vizier vie for a magic lamp that has the power to make their deepest wishes come true.")

      #Act
      results1 = movie1.valid?
      # results2 = movie2.valid?
      # Assert
      expect(results1).must_equal false
      # expect(results2).must_equal true
    end
  end

  describe "spotlight" do

  end

  describe "relationships" do
    before do
      @user = User.create(username:"Ana")
      @work = Work.create(media: "movie", title: "Aladdin", created_by: "Walt Disney Studios", published: "1992", description: "A kindhearted street urchin and a power-hungry Grand Vizier vie for a magic lamp.")
      @vote = Vote.create(user_id: @user.id, work_id: @work.id)
    end

    it "can have have many votes" do

      expect(@work.votes.length).must_equal 2
      expect(@work.votes[0]).must_be_kind_of Vote

    end
  end
end
