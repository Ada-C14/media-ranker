require "test_helper"

describe Work do

  describe 'validations' do
    it "is valid when all field are present" do
      #Arrange
      work = works(:working_media)

      #Act
      result = work.valid?

      #Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      #Arrange
      work = works(:bad_media)

      #Act
      result = work.valid?

      #Assert
      expect(work.valid?).must_equal false
    end


  end


end
