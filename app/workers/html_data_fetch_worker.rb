class HtmlDataFetchWorker
  @queue = :html_data_fetch_worker

  def self.perform(method, year)
    DataFetcher.send("#{method}", year)
  end
end
