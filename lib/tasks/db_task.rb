require 'my_string.rb'

namespace :db_task do
  task :remove_diacritics => :environment do
    Highschool.find_each { |h| h.update(name: h.name.remove_diacritics) }
    Section.find_each { |s| s.update(name: s.name.remove_diacritics) }
  end

  task :add_first_rate_to_highschool_details => :environment do
    HighschoolDetail.find_each do |hd|
      first_rate = AdmissionResult.where(highschool_detail_id: hd.id).order('admission_rate DESC').first
      admissiona_rate = AdmissionResult.where(highschool_detail_id: hd.id).order('admission_rate DESC').first.admission_rate if AdmissionResult.where(highschool_detail_id: hd.id).order('admission_rate DESC').first
      hd.update(first_rate: admission_rate)
    end
  end

  task :add_position_to_en_r => :environment do
    County.find_each do |county|
      counter = 1;
      from_county = EvaluationResult.where("year = (?) AND county_id = (?)", 2015, county.id).order('evaluation_rate DESC')
      from_county.each do |e|
        e.update(position: counter)
        counter = counter + 1
      end
    end
  end

  task :add_position_to_admission => :environment do
    County.find_each do |county|
      counter = 1;
      from_county = AdmissionResult.where("year = (?) AND county_id = (?)", 2015, county.id).order('evaluation_rate DESC')
      from_county.each do |e|
        e.update(position: counter)
        counter = counter + 1
      end
    end
  end
end
