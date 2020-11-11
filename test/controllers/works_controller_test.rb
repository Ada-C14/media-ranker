require "test_helper"

describe WorksController do
  describe "show" do
    it "will get show for valid ids" do
      # Arrange
      valid_work_id = 1

      # Act
      get "/works/#{valid_work_id}"

      # Assert
      must_respond_with :success
    end

    it "will respond with not_found for invalid ids" do
      # Arrange
      invalid_work_id = 999

      # Act
      get "/works/#{invalid_work_id}"

      # Assert
      must_respond_with :not_found
    end
  end
end
