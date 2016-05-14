class Importer
  require 'csv'

  # import highschools and save them to highshools table
  # @param file [String] - path to the temporary csv file
  #
  # @return [Highschool]
  def self.import_highschools(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    Highschool.delete_all
    csv.each do |row|
      Highschool.create!(name: row['Nume Scoala'],
                         county: County.where(name: row['Judet']).first) unless Highschool.find_by_name(row['Nume Scoala'])
    end
    csv_processed_email('highschools')
  end

  # import admission results and save them to the AdmissionResults table
  # @param file [String] - path to the temporary csv file
  #
  # @return [AdmissionResult]
  def self.import_admission_results(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      # add logic to insert into db
      AdmissionResult.import_data(row)
    end
    csv_processed_email('admission results')
  end

  # import evaluation results and save them to the EvaluationResults table
  # @param file [String] - path to the temporary csv file
  #
  # @return [EvaluationResult]
  def self.import_evaluation_results(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      # add logic to insert into db
      EvaluationResult.import_data(row)
    end
    csv_processed_email('evaluation results')
  end

  # import counties and save them to the Counties table
  # @param file [String] - path to the temporary csv file
  #
  # @return [Highschool]
  def self.import_counties(file)
    County.delete_all
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      County.create!(name: row['Judet']) unless County.find_by_name(row['Judet'])
    end
    csv_processed_email('counties')
  end

  private

  def self.csv_processed_email(import_type)
    NotificationMailer.csv_successfully_imported(import_type)
  end
end
