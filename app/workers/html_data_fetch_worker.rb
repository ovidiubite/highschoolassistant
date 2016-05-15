class HtmlDataFetchWorker
  @queue = :html_data_fetch_worker

  def self.perform(year)
    DataFetcher.fetch_highschools(year)
  end
end
