# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'


work_failures = []

WORK_FILE = Rails.root.join('db', 'works-seeds.csv')
puts "Loading raw work data from #{WORK_FILE}"

id = 1
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  # work.id = id
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.published = row['publication_year']
  work.description = row['description']

  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
  id += 1
end

puts "Added #{Work.count} works"
puts "#{work_failures.length} works failed to save"