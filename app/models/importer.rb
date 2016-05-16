class Importer
  require 'csv'

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

  private

  def self.csv_processed_email(import_type)
    NotificationMailer.csv_successfully_imported(import_type)
  end
end
