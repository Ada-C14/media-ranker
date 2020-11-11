require "faker"
require "date"
require "csv"

# we already provide a filled out works_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new works_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open("db/works_seeds.csv", "w", :write_headers => true,
                                    :headers => ["category", "title", "creator", "publication_year", "description"]) do |csv|
  25.times do
    category = %w(album book movie).sample
    title = Faker::Coffee.blend_name
    creator = Faker::Name.name
    publication_year = rand(Date.today.year - 100..Date.today.year)
    description = Faker::Lorem.sentence

    csv << [category, title, creator, publication_year, description]
  end
end

CSV.open("db/users_seeds.csv", "w", :write_headers => true,
         :headers => ["name", "date_joined"]) do |csv|
  25.times do
    name = Faker::Name.name
    date_joined = rand((Date.today - 100)..(Date.today - 50))

    csv << [name, date_joined]
  end
end

CSV.open("db/votes_seeds.csv", "w", :write_headers => true,
         :headers => ["user_id", "work_id", "date voted"]) do |csv|
  40.times do
    user_id = rand(1..25)
    work_id = rand(1..25)
    date_voted = rand((Date.today - 49)..(Date.today))

    csv << [user_id, work_id, date_voted]
  end
end
