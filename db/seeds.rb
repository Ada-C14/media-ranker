# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

WORK_FILE = Rails.root.join('db', 'works_seeds.csv')
puts "Loading works data from #{WORK_FILE}"

work_upload_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new

  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']

  successful = work.save
  if !successful
    work_upload_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_upload_failures.size} works failed to save"

user_upload_failures = []
20.times do |num|
  user = User.new

  user.username = "user#{num}"

  successful = user.save
  if !successful
    user_upload_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_upload_failures.size} users failed to save"

puts "done"
