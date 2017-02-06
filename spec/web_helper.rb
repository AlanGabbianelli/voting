def run_the_rake_task
  require 'rake'
  rake = Rake::Application.new
  Rake.application = rake
  Rake::Task.define_task(:environment)
  load "#{Rails.root}/lib/tasks/import.rake"
  rake['import:votes'].invoke('votes_sample.txt')
end
