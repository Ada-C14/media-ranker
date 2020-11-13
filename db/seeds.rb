# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# MODIFIED FROM seeds.rb from ride share rails project
#
require 'csv'

WORK_FILE = Rails.root.join('db', 'works-seeds.csv')
puts "Loading raw driver data from #{WORK_FILE}"

id = 1

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.id = id
  work.title = row['title']
  work.category = row['category']
  work.creator = row['creator']
  work.publication_year = row['publication_year'].to_i
  work.description = row['description']
  sleep(1) # will always seed with different creation times
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
    id += 1
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"


