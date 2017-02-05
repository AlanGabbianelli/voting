namespace :import do
  desc '-- Imports votes from a .txt file passed as argument'
  task :votes, [:file] => [:environment] do |_t, args|
    args.with_defaults(file: "#{Rails.root}/votes.txt")
    File.foreach(args[:file]) do |line|
      needed_part = line.scrub('').split.take(5)
      campaign = Campaign.find_or_create_by!(name: needed_part[2][9..-1])
      choice = campaign.choices.find_or_create_by!(name: needed_part[4][7..-1])
      choice.votes.find_or_create_by!(
        time: Time.at(needed_part[1].to_i),
        validity: needed_part[3][9..-1],
        valid_vote: needed_part[3][9..-1] == 'during' ? true : false
      )
      print '.'
    end
    puts
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts 'File successfully imported!'
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts
  end
end
