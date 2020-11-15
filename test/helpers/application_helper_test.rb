# test/helpers/application_helper_test.rb
require "test_helper"

describe ApplicationHelper, :helper do
  describe 'flash_class' do
    it "shows alert-success css with the flash[:success]" do
        level = "success"
  
        result = flash_class(level)
  
        expect(result).must_equal "alert-success"
      end
  
      it "shows alert-warning css with the flash[:error]" do
        level = "error"
  
        result = flash_class(level)
  
        expect(result).must_equal "alert-warning"
      end
  end
end