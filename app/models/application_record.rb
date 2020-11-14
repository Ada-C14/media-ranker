class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_errors
    return errors.map do |attribute, message|
      "#{attribute.capitalize.to_s.gsub("_id", "")} #{message}"
    end
  end
end
