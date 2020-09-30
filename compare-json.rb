require 'optparse'

# Receives two arguments indicating the path of the json files to compare
# opens the files, compare and return the similarity

options = {}
OptionParser.new do |opts|
    opts.banner = "\nUsage: ruby compare-json.rb json_path_1 json_path_2"
  
    opts.on( '-h', '--help', 'Display this screen' ) do
        puts opts
    end

    if ARGV.empty? or ARGV.length != 2
        puts opts
        exit(-1)
    end
    
end.parse!
