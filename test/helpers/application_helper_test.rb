require "test_helper"

describe ApplicationHelper, :helper do
  describe 'standardize_date' do
    it "returns a standard date" do
      date = Date.today

      result = standardize_date(date)

      expect(result).must_include date.strftime("%b %m, %Y")
    end

    it "returns [unknown] if the date is nil" do
      date = nil

      result = standardize_date(date)

      expect(result).must_equal "[unknown]"
    end
  end
end