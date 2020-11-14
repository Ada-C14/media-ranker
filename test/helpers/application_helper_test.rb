
require "test_helper"

describe ApplicationHelper,:helper do
  describe 'flash_class(level' do
    it 'will return the correct flash message class' do
      flash = :warning
      result = flash_class(flash)
      expect(result).must_equal "alert-warning"
    end
  end
end