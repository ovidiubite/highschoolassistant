class CsvImporterWorker
  @queue = :csv_importer_worker

  def self.perform(file)
    Importer.import_highschools(file)
  end
end
