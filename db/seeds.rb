require 'csv'

WORK_FILE = Rails.root.join('db', 'seed_data', 'works.csv')
puts "Loading raw work data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.id = row['id']
  work.title = row['title']
  work.description = row['description']
  work.creator = row['creator']
  work.publication_date = row['publication_date']
  work.category = row['category']
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end


