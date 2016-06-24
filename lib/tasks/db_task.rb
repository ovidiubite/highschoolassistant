require 'my_string.rb'

namespace :db_task do
  task :remove_diacritics => :environment do
    Highschool.find_each { |h| h.update(name: h.name.remove_diacritics) }
    Section.find_each { |h| s.update(name: s.name.remove_diacritics) }
  end
end
