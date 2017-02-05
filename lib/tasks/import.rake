namespace :import do
  desc '-- Imports votes from a .txt file passed as argument'
  task :votes, [:file] => [:environment] do |_t, args|
    args.with_defaults(file: "#{Rails.root}/votes.txt")
    File.foreach(args[:file]) do |line|
      needed_part = line.scrub('').split.take(5)
      puts needed_part
      puts '=================================='
    end
  end
end
