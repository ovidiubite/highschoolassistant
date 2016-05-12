class Importer
  require 'csv'

  def self.import_highschools(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    Highschool.delete_all
    csv.each do |row|
      Highschool.create!(name: row['Nume Scoala'])
    end
  end

  def self.import_admission_results(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|

      # add logic to insert into db
    end
  end

  def self.import_evaluation_results(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      # add logic to insert into db
    end
  end

  def self.import_counties(file)
    County.delete_all
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      County.create!(name: row['den_j'])
    end
  end
end
