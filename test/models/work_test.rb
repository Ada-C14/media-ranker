require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(category: "album", title: "七里香", creator: "周杰伦", publication_year: 2004)

    end

    it 'is valid when all fields are present' do
      expect(@work.valid?).must_equal true
    end

    it 'is invalid without a title' do
      @work.title = nil
      expect(@work.valid?).must_equal false
      #@work.save
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid with a non-unique title' do
      unique_work = Work.create!(category: "album", title: "lol")
      @work.title = unique_work.title

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without a category' do
      @work.category = nil
      expect(@work.valid?).must_equal false
    end

    it 'is invalid with a invalid category name' do
      @work.category = "game"
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end
  end

  describe 'relations' do
    it 'has many votes' do
      work = works(:jieyou)
      work.save
      user = users(:lisa)
      user.save
      Vote.create!(user_id: user.id, work_id: work.id)
      expect(Work.find(work.id).votes.length).must_equal 1
      expect
    end

  end
end
