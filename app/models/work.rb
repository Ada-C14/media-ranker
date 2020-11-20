# frozen_string_literal: true

class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category, message: "Work with this title already exists in this category" }
  validates :category, presence: true, inclusion: { in: %w(album book movie), message: "%{value} is not a valid category"}
  validates :publication_year, numericality: { only_integer: true, message: "Enter the year in mumaric value" }

  def self.spotlight
    Work.all.max_by(10) { |work| work.votes.count }
  end

  def self.top_10(category)
    Work.all.where(category: category).max_by(10) { |work| work.votes.count }
  end
end
