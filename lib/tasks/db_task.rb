require 'my_string.rb'

namespace :db_task do
  task :remove_diacritics => :environment do
    Highschool.find_each { |h| h.update(name: h.name.remove_diacritics) }
    Section.find_each { |h| s.update(name: s.name.remove_diacritics) }
  end

  task :add_first_rate_to_highschool_details do
    HighschoolDetail.find_each do |hd|
      first_rate = AdmissionResult.where(highschool_detail_id: hd.id).order('admission_rate DESC').first
      hd.update(first_rate: first_rate)
    end
  end
end
