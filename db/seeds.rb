# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

WORKS_FILE = Rails.root.join('db', 'works-seeds.csv')

work_failures = []

CSV.foreach(WORKS_FILE, :headers => true) do |row|
  work = Work.new
  work.id = row['id']
  work.title = row['title']
  work.description = row['description']
  work.publication_date = row['publication_year']
  work.creator = row['creator']
  work.category = row['category']
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created driver: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"



