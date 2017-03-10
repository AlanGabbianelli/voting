require 'partial_line'

namespace :import do
  desc '-- Imports votes from a .txt file passed as argument'
  task :votes, [:file] => [:environment] do |_t, args|
    args.with_defaults(file: "#{Rails.root}/votes.txt")
    
    File.foreach(args[:file]) do |line|
      partial_line = PartialLine.new(line.scrub('').split.take(5))
      partial_line.create_models! if partial_line.well_formed?
    end
  end
end
