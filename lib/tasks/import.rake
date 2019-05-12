require 'partial_line'

namespace :import do
  desc '-- Imports votes from a .txt file passed as argument'
  task :votes, [:file] => [:environment] do |_t, args|
    args.with_defaults(file: "#{Rails.root}/votes.txt")

    File.foreach(args[:file]) do |line|
      scrubbed_line = line.scrub('') # to remove unwanted characters
      partial_line = PartialLine.new(scrubbed_line.split.take(5))
      partial_line.create_models! if partial_line.well_formed?
    end
  end
end
