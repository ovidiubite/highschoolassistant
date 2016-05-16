class DataFetcher
  include ApplicationHelper
  require 'nokogiri'
  require 'open-uri'
  require 'resolv-replace'

  def self.fetch_highschools(year = Date.today.year)
    highschool_number = 101
    county_number= 0

    driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").read
  	while 1
  		doc = Nokogiri::HTML(driver)

  		county = ApplicationHelper::HASH_COUNTIES[ApplicationHelper::COUNTIES[county_number].to_sym]

      highschool_name = doc.css("center font.heading2 i").text

      table = doc.css('table.mainTable tr')
  		table.each do |t|
        next if t.css('td')[0] == nil
        highschool = Highschool.find_or_create_by(name: highschool_name,
                           county: County.find_or_create_by(name: county))

        section = Section.find_or_create_by(name: t.css('td')[3].text)

        HighschoolDetail.create(year: year,
                                students_number: t.css('td')[5].text,
                                section_id: section.id,
                                highschool_id: highschool.id,
                                last_rate: t.css('td')[11].text)

      end
      highschool_number = highschool_number + 1

    	# county_number, highschool_number, doc = rescue_http_error(county_number, highschool_number, year)
      # break if county_number == 41

      begin
        driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").read
        doc = Nokogiri::HTML(driver)
  		rescue OpenURI::HTTPError
        break if county_number == 41
  			county_number = county_number + 1
        highschool_number = 101
        begin
          driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").read
  			  doc = Nokogiri::HTML(driver)
        rescue OpenURI::HTTPError
          break if county_number == 41
          county_number = county_number + 1
          highschool_number = 101
          driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").read
  			  doc = Nokogiri::HTML(driver)
        end
      end
  	end
  end

  def self.rescue_http_error(county_number, highschool_number, year)
    begin
      driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").read
      doc = Nokogiri::HTML(driver)
      return county_number, highschool_number, doc
    rescue OpenURI::HTTPError
      county_number = county_number + 1
      highschool_number = 101
      rescue_http_error county_number, highschool_number, year
    end
  end
end