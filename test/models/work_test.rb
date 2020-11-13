require "test_helper"

describe Work do
  describe 'validations' do
    it 'is valid when all fields are present' do
      # Act
      work = works(:kreb_album)

      result = work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      # Arrange
      work = works(:kreb_album)
      work.title = nil
    
      # Act
      result = work.valid?
    
      # Assert
      expect(result).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it 'is invalid with a non-unique username' do
      # Arrange
      non_uniq_work = Work.new(
        category: "book",
        title: "Mitsubachi to Enrai",
        creator: "Blaise Lesch",
        publication_year: 1968,
        description: "Voluptatem adipisci qui velit."
        )

      non_uniq_work.title = works(:kreb_album).title

      # Act
      result = non_uniq_work.valid?

      # Assert
      expect(result).must_equal false
      expect(non_uniq_work.errors.messages).must_include :title
    end
  end

  describe 'relations' do
    it "has many votes" do
      skip
    end

    it "have many users thru votes" do
      skip
    end
  end
end
