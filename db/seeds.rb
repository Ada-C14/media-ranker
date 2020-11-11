# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
#
require 'csv'

WORK_FILE = Rails.root.join('db', 'works-seeds.csv')
puts "Loading raw work data from #{WORK_FILE}"
work_failures = []
works = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new({
                       category: row['category'],
                       title: row['title'],
                       creator: row['creator'],
                       publication_date: row['publication_date'],
                       description: row['description']
                   })
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    works << work
    puts "Created work: #{work.inspect}"
  end
end


USER_FILE = Rails.root.join('db', 'users-seeds.csv')
puts "Loading raw user data from #{USER_FILE}"
user_failures = []
users = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new({
                      name: row['name']
                  })
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    users << user
    puts "Created user: #{user.inspect}"
  end
end

25.times do |i|
  user = users[rand(users.length)]
  work = works[rand(works.length)]
  vote = Vote.create({user_id: user.id, work_id: work.id})
  if !vote
    puts "Failed to create vote: #{vote.inspect}"
  else
    puts "Created vote: #{vote.inspect}"
  end
end


