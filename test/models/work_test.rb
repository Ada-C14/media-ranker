require "test_helper"

describe Work do
  let (:work) {
    Work.new(title: 'Work', category: 'movie', description: 'a',
             publication_year: 1999, creator: 'a')
  }

  describe "Instantiation and validations" do
    it "can create a work object" do
      expect(work.valid?).must_equal true
    end

    it "will have the required fields" do
      work.save
      work_obj = Work.find_by(title: 'Work')
      [:title, :category, :description, :publication_year, :creator].each do |field|

        # Assert
        expect(work_obj).must_respond_to field
      end
    end

    it 'must have a title' do
      work.title = nil
      expect(work.valid?).must_equal false
    end

    it 'must have an integer for publication year' do
      work.publication_year = "a'"
      expect(work.valid?).must_equal false
      work.publication_year = 3.0
      expect(work.valid?).must_equal false
    end

    it 'can have a blank/nil publication year' do
      blank_work = Work.new(title: 'ccc', category: 'movie')
      expect(blank_work.valid?).must_equal true
      work.publication_year = nil
      expect(work.valid?).must_equal true
      work.publication_year = ""
      expect(work.valid?).must_equal true
    end

    it 'must have a valid category' do
      work.category = "applesauce"
      expect(work.valid?).must_equal false
    end

    it 'must have a title' do
      work.title = nil
      expect(work.valid?).must_equal false
    end

    it 'must have a unique title' do
      cat = works(:cat)
      dog = works(:dog)
      dog.title = cat.title
      expect(dog.valid?).must_equal false
    end
  end

  describe "Custom methods" do
    it 'media spotlight picks a work when there are works' do
      expect(Work.media_spotlight).must_be_kind_of Work
    end

    it 'media spotlight returns nil when there are no works' do
      Work.delete_all
      expect(Work.media_spotlight).must_be_nil
    end

    describe 'top ten' do
      before do
        10.times do |n|
          Work.create!(title: n.to_s, category: 'movie')
        end
      end

      it 'top_ten returns 10 works when there are ten works' do
        works = Work.top_ten('movie')
        expect(works.length).must_equal 10
        works.each do |work|
          expect(work).must_be_kind_of Work
        end
      end

      it 'top_ten returns one work when there is one work' do
        works = Work.top_ten('book')
        expect(works.length).must_equal 1
        expect(works.first).must_be_kind_of Work
      end

      it 'top_ten returns nil when there are no works' do
        Work.delete_all
        expect(Work.top_ten('book').empty?).must_equal true
        expect(Work.top_ten('movie').empty?).must_equal true
        expect(Work.top_ten('album').empty?).must_equal true
      end
    end

  end
end
