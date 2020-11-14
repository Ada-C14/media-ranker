require "test_helper"

describe Work do
  describe 'validations' do
    it 'is valid when all fields are present' do
      # Act
      work = works(:kreb_album)
      
      # Arrange
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

    it 'is invalid with a non-unique title' do
      # Arrange
      uniq_work = Work.create!(
        category: "book",
        title: "Mitsubachi to Enrai",
        creator: "Blaise Lesch",
        publication_year: 1968,
        description: "Voluptatem adipisci qui velit."
      )
      works(:kreb_album).title = uniq_work.title

      # Act
      result = works(:kreb_album).valid?

      # Assert
      expect(result).must_equal false
      expect(works(:kreb_album).errors.messages).must_include :title
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
