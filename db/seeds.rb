# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

media_file = Rails.root.join('db', 'works_seeds.csv')
puts "Loading raw faker data from #{media_file}"

work_failures = []
CSV.foreach(media_file, headers: true, header_converters: :symbol, converters: :all) do |row|

  data = Hash[row.headers.zip(row.fields)]

  successful = Work.create!(data)

  if !successful
    work_failures << row
    puts "Failed to save: #{row.fields}"
  else
    puts "Created: #{row.fields}"
  end
end

puts "Added #{Work.count} records"
puts "#{work_failures.length} records failed to save"