require "faker"
require "date"
require "csv"

# we already provide a filled out works_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_starter_data.rb
# if satisfied with this new works_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open("db/works-seeds.csv", "w", :write_headers => true,
                                    :headers => ["category", "title", "creator", "publication_year", "description"]) do |csv|
  25.times do
    category = %w(album book movie).sample
    title = Faker::TvShows::TwinPeaks.unique.location
    creator = Faker::TvShows::RickAndMorty.unique.character
    publication_year = rand(Date.today.year - 100..Date.today.year)
    description = Faker::ChuckNorris.unique.fact

    csv << [category, title, creator, publication_year, description]
  end
end

CSV.open("db/users-seeds.csv", "w", :write_headers => true,
        :headers => ["name"]) do |csv|
  25.times do
    name = Faker::Games::Minecraft.unique.mob

    csv << [name]
  end
end