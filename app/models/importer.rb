class Importer
  require 'csv'

  def self.import_highschools(file)
    csv_text = File.read(file.path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Highschool.create!(name: row['Nume Scoala'])
    end
  end
end
