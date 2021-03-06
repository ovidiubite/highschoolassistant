class DataFetcher
  require 'my_string.rb'
  include ApplicationHelper
  require 'nokogiri'
  require 'open-uri'
  require 'resolv-replace'
  require 'charlock_holmes'

  def self.fetch_highschools(year = Date.today.year)
    highschool_number = 101
    county_number= 0

    driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").binmode.read
    while 1
  		doc = Nokogiri::HTML(driver)

  		county = ApplicationHelper::HASH_COUNTIES[ApplicationHelper::COUNTIES[county_number].to_sym]

      highschool_name = doc.css("center font.heading2 i").text.strip

      table = doc.css('table.mainTable tr')
  		table.each do |t|
        next if t.css('td')[0] == nil
        highschool = Highschool.find_or_create_by(name: highschool_name,
                           county: County.find_or_create_by(name: county))

        section = Section.find_or_create_by(name: t.css('td')[3].text.strip)

        HighschoolDetail.create(year: year,
                                students_number: t.css('td')[5].text.strip,
                                section_id: section.id,
                                highschool_id: highschool.id,
                                last_rate: t.css('td')[11].text.strip)

      end
      highschool_number = highschool_number + 1

    	# county_number, highschool_number, doc = rescue_http_error(county_number, highschool_number, year)
      # break if county_number == 41

      begin
        driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").binmode.read
        doc = Nokogiri::HTML(driver)
  		rescue OpenURI::HTTPError
        break if county_number == 41
  			county_number = county_number + 1
        highschool_number = 101
        begin
          driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").binmode.read
  			  doc = Nokogiri::HTML(driver)
        rescue OpenURI::HTTPError
          break if county_number == 41
          county_number = county_number + 1
          highschool_number = 101
          driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").binmode.read
  			  doc = Nokogiri::HTML(driver)
        end
      end
  	end
  end

  def self.fetch_evaluation_results(year = (Time.now - 1.year).year)
    county_number= 0
    pag_number = 1
    begin
      driver = open("http://static.evaluare.edu.ro/#{year}/rapoarte/j/#{ApplicationHelper::COUNTIES[county_number]}/cand/m/page_#{pag_number}").binmod.read
    rescue OpenURI::HTTPError
      return ""
    end
    while 1
      doc = Nokogiri::HTML(driver)

      county = ApplicationHelper::HASH_COUNTIES[ApplicationHelper::COUNTIES[county_number].to_sym]

      table = doc.css('table.mainTable tr')
      table.each do |t|
        next if t.css('td')[0].text.strip == 'Index' || t.css('td')[0].text.strip == 'Notă'
        next if t.css('td')[14].text.strip == '-'

        #  grade_math      :integer
        #  grade_romana    :integer
        #  grade_native    :integer
        EvaluationResult.create(county_id: County.find_or_create_by(name: county).id,
                                school: t.css('td')[3].text.strip,
                                evaluation_rate: t.css('td')[14].text.strip,
                                year: year)
      end
      pag_number = pag_number + 1

      begin
        driver = open("http://static.evaluare.edu.ro/#{year}/rapoarte/j/#{ApplicationHelper::COUNTIES[county_number]}/cand/m/page_#{pag_number}").binmode.read
        doc = Nokogiri::HTML(driver)
      rescue OpenURI::HTTPError
        break if county_number == 41
        county_number = county_number + 1
        pag_number = 1
        begin
          driver = open("http://static.evaluare.edu.ro/#{year}/rapoarte/j/#{ApplicationHelper::COUNTIES[county_number]}/cand/m/page_#{pag_number}").binmode.read
          doc = Nokogiri::HTML(driver)
        rescue OpenURI::HTTPError
          break if county_number == 41
          county_number = county_number + 1
          pag_number = 1
          driver = open("http://static.evaluare.edu.ro/#{year}/rapoarte/j/#{ApplicationHelper::COUNTIES[county_number]}/cand/m/page_#{pag_number}").binmode.read
          doc = Nokogiri::HTML(driver)
        end
      end
    end
  end

  def self.fetch_admission_results(year = (Time.now - 1.year).year)
    county_number= 0
    pag_number = 1
    begin
      # driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}").binmode.read
      drive = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}") do |f|
               Encoding.default_external = f.charset
               html = f.read
              end


    rescue OpenURI::HTTPError
      if !driver.is_utf8?
        detection = CharlockHolmes::EncodingDetector.detect(driver)
        driver = CharlockHolmes::Converter.convert driver, detection[:encoding], 'UTF-8'
      end
      # return ""
    end
    while 1
      doc = Nokogiri::HTML(driver)

      county = ApplicationHelper::HASH_COUNTIES[ApplicationHelper::COUNTIES[county_number].to_sym]

      table = doc.css('table.mainTable tr')
      table.each do |t|
        next if t.css('th')[0].present?

        # a link
        highschool = Highschool.find_by(name: t.css('td')[13].css('a').text.strip.remove_diacritics)

        section = Section.find_by(name: t.css('td')[14].css('a').text.strip.remove_diacritics)

        next if highschool.nil? || section.nil?

        highschool_details = HighschoolDetail.where(section_id: section.id, highschool_id: highschool.id, year: year).first

        next if highschool_details.nil?

        AdmissionResult.find_or_create_by(county_id: County.find_or_create_by(name: county).id,
                                section_id: section.id,
                                highschool_detail_id: highschool_details.id,
                                evaluation_rate: t.css('td')[5].text.strip,
                                admission_rate: t.css('td')[4].text.strip,
                                graduation_rate: t.css('td')[6].text.strip,
                                year: year)
      end
      pag_number = pag_number + 1

      begin
        drive = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}") do |f|
                 Encoding.default_external = f.charset
                 html = f.read
                end

        # driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}").binmode.read
        doc = Nokogiri::HTML(driver)
      rescue OpenURI::HTTPError
        break if county_number == 41
        county_number = county_number + 1
        pag_number = 1
        begin
          drive = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}") do |f|
                   Encoding.default_external = f.charset
                   html = f.read
                  end

          # driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}").binmode.read
          doc = Nokogiri::HTML(driver)
        rescue OpenURI::HTTPError
          break if county_number == 41
          county_number = county_number + 1
          pag_number = 1
          drive = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}") do |f|
                   Encoding.default_external = f.charset
                   html = f.read
                  end

          # driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/cina/page_#{pag_number}").binmode.read
          doc = Nokogiri::HTML(driver)
        end
      end
    end
  end

  def self.rescue_http_error(county_number, highschool_number, year)
    begin
      driver = open("http://static.admitere.edu.ro/#{year}/staticRepI/j/#{ApplicationHelper::COUNTIES[county_number]}/lic/#{highschool_number}/").binmode.read
      doc = Nokogiri::HTML(driver)
      return county_number, highschool_number, doc
    rescue OpenURI::HTTPError
      county_number = county_number + 1
      highschool_number = 101
      rescue_http_error county_number, highschool_number, year
    end
  end
end
