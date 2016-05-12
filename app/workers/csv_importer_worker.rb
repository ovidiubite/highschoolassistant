class CsvImporterWorker
  @queue = :csv_importer_worker

  # run rake resque:workers
  # run bundle exec rake environment resque:work QUEUE=*

  # Background job
  # @param file [String] - path of the csv file
  # @param method [String] - methods to be called in Importer class
  #
  # @return [Boolean]
  def self.perform(file, method)
    Importer.send("#{method}", file)
  end
end
