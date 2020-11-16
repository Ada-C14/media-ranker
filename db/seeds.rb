# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

WORK_FILE = Rails.root.join('db', 'seed_data', 'works-seeds.csv')
puts "Loading raw driver data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.id = row['id']
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} work failed to save"



USER_FILE = Rails.root.join('db', 'seed_data', 'users-seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.id = row['id']
  user.name = row['name']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

#
#
# TRIP_FILE = Rails.root.join('db', 'seed_data', 'trips.csv')
# puts "Loading raw trip data from #{TRIP_FILE}"
#
# trip_failures = []
# CSV.foreach(TRIP_FILE, :headers => true) do |row|
#   trip = Trip.new
#   trip.id = row['id']
#   trip.driver_id = row['driver_id']
#   trip.user_id = row['user_id']
#   trip.date = Date.strptime(row['date'], '%Y-%m-%d')
#   trip.rating = row['rating']
#   trip.cost = row['cost']
#   successful = trip.save
#   if !successful
#     trip_failures << trip
#     puts "Failed to save trip: #{trip.inspect}"
#   else
#     puts "Created trip: #{trip.inspect}"
#   end
# end
#
# puts "Added #{Trip.count} trip records"
# puts "#{trip_failures.length} trips failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
