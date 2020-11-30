require "test_helper"

describe WorksController do
  describe 'index' do
    it 'can get the works path' do
      get works_path
      must_respond_with :success
    end
  end

  describe 'new' do
    it 'can get the new work path' do
      get new_work_path
      must_respond_with :success
    end
  end
  describe 'show' do
    it 'can get the show page' do
      get work_path(works(:test_album))
      must_respond_with :success
    end

    it "responds with not found / 404 if id is invalid" do
      get work_path(-1)
      must_respond_with :not_found
    end
  end
  describe 'create' do
    work_hash = {
          work: {
              category: "book",
              title: "The Pest",
              creator: "I dunno",
              publication_year: "1990",
              description: "John Leguizamo is the Pest"
          }
      }
    it "can create a work" do
      expect {
        post works_path, params: work_hash
      }.must_differ 'Work.count', 1

      movie = Work.find_by(title: "The Pest")
      must_respond_with :redirect
      must_redirect_to work_path(work: movie, work_id: movie)
      expect(flash[:success]).wont_be_nil

      expect(movie.category).must_equal work_hash[:work][:category]
      expect(movie.title).must_equal work_hash[:work][:title]
      expect(movie.creator).must_equal work_hash[:work][:creator]
      expect(movie.publication_year).must_equal work_hash[:work][:publication_year]
      expect(movie.description).must_equal work_hash[:work][:description]

    end

    it "will not create work if params are invalid" do
      work_hash[:work][:title] = nil

      expect {
        post works_path, params: work_hash
      }.wont_differ 'Work.count'

      expect(flash[:error]).wont_be_nil
      must_respond_with :bad_request
    end
  end

  describe 'update' do

  end

  describe 'destroy' do
    describe "destroy" do
      it "successfully deletes work, redirects to index and reduces count by 1" do
        expect {
          delete work_path(works(:test_album))
        }.must_differ 'Work.count', -1

        must_respond_with :redirect
        must_redirect_to works_path
        expect(flash[:success]).wont_be_nil
      end

      it "decreases associated user's vote count by 1" do
        user = users(:first)

        expect {
          delete work_path(works(:test_album))
        }.must_differ 'user.votes.count', -1

      end

      it "will redirect to index if invalid id" do
        expect {
          delete work_path(-1)
        }.wont_differ 'Work.count'

        must_respond_with :not_found
      end
    end
  end

end
