require 'partial_line'

namespace :import do
  desc '-- Imports votes from a .txt file passed as argument'
  task :votes, [:file] => [:environment] do |_t, args|
    args.with_defaults(file: "#{Rails.root}/votes.txt")
    File.foreach(args[:file]) do |line|
      partial_line = PartialLine.new(line.scrub('').split.take(5))
      if partial_line.well_formed?
        campaign = Campaign.find_or_create_by!(name: partial_line.campaign_name)
        choice = campaign.choices.find_or_create_by!(name: partial_line.choice_name)
        choice.votes.find_or_create_by!(
          time: partial_line.vote_time,
          validity: partial_line.vote_validity,
          valid_vote: partial_line.valid_vote?
        )
        print '.'
      end
    end
    puts
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts 'File successfully imported!'
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts
  end
end
