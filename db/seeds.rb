# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

MEDIA_FILE = Rails.root.join('db', 'works_seeds.csv')
puts "Loading works data from #{MEDIA_FILE}"

works_failures = []

CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    works_failures << successful
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{works_failures.length} works failed to save "

USER_FILE = Rails.root.join('db', 'users_seeds.csv')
puts "Loading User data from #{USER_FILE}"

users_failures = []

CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.username = row['username']
  successful = user.save
  if !successful
    users_failures << successful
    puts "Failed to save work: #{user.inspect}"
  else
    puts "Created work: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{users_failures.length} users failed to save"