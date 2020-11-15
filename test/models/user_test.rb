require "test_helper"

describe User do
  describe "relations" do
    it "has many votes" do
      user = users(:pooh)
      pooh_votes_dune = votes(:pooh_dune)
      pooh_votes_odesza = votes(:pooh_odesza)

      expect(user.votes).must_include pooh_votes_dune
      expect(user.votes).must_include pooh_votes_odesza
    end

    it "has many works through votes" do
      user = users(:pooh)
      pooh_votes_dune = votes(:pooh_dune)
      pooh_votes_odesza = votes(:pooh_odesza)

      expect(user.works).must_include works(:dune)
      expect(user.works).must_include works(:odesza)
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
