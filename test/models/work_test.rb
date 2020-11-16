require 'test_helper'
require 'pry'

describe Work do

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
      #Act
      results1 = movie1.valid?

      # Assert
      expect(results1).must_equal false
    end
  end

  describe "spotlight" do

    it "will select the top media with highest votes" do

      spotlight = Work.spotlight
      expect(spotlight).must_be_kind_of Work

      # user = User.find_by(username: "lola")
      # #FIXTURE? maybe with user = users :lola
      # work = Work.find_by(title: "finding nemo")
      # #FIXTURE? work = works :album1
      # Vote.create(user_id: lola.id, work_id: finding_nemo.id)
      # expect Work.spotlight = finding_nemo
    end

    it "will return an error if there are none" do

      Work.destroy_all
      spotlight = Work.spotlight
      expect(spotlight).must_equal nil

    end

    it "if theres a tie, it gets the first alphabetical work"

    it "if there is a tie between two types of media it will default to movie"
  end

  describe "relationships" do
    # before do
    #   @user = User.create(username:"Ana")
    #   @work = Work.create(media: "movie", title: "Aladdin", created_by: "Walt Disney Studios", published: "1992", description: "A kindhearted street urchin and a power-hungry Grand Vizier vie for a magic lamp.")
    #   @vote = Vote.create(user_id: @user.id, work_id: @work.id)
    # end

    it "can  have many votes"

    #   user = User :lola
    #
    #   expect(@work.votes.length).must_equal 2
    #   expect(@work.votes[0]).must_be_kind_of Vote
    #
    # end
  end
end
