require "test_helper"

describe User do
  describe "relations" do
    before do
      @pooh = users(:pooh)

      @dune = works(:dune)
      @odesza = works(:odesza)

      @pooh_vote_dune = votes(:pooh_dune)
      @pooh_votes_odesza = votes(:pooh_odesza)
    end

    it "has many votes" do
      expect(@pooh.votes).must_include @pooh_votes_dune
      expect(@pooh.votes).must_include @pooh_votes_odesza
    end

    it "has many works through votes" do
      expect(@pooh.works).must_include @dune
      expect(@pooh.works).must_include @odesza
    end
  end

  describe "validations" do
    it "must have a username" do
      user = User.create()

      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
end
