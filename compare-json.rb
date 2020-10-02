require 'optparse'
require 'string/similarity'
require 'fuzzystringmatch'
require 'jaro_winkler'

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

json_path_1 = ARGV[0]
json_path_2 = ARGV[1]

#validate files
if !File.file?(json_path_1)
    puts "'#{json_path_1}' is not a valid file or does not exist"
    exit(-1)
end

if !File.file?(json_path_2)
    puts "'#{json_path_2}' is not a valid file or does not exist"
    exit(-1)
end

json_1 = File.read(json_path_1)
json_2 = File.read(json_path_2)


cossine_sim = String::Similarity.cosine json_1, json_2
levenshtein_similarity = String::Similarity.levenshtein json_1, json_2
jarow_sim = FuzzyStringMatch::JaroWinkler.create( :pure ).getDistance json_1, json_2
jw_dist = JaroWinkler.distance json_1, json_2


p cossine_sim
p levenshtein_similarity
p jarow_sim
p jw_dist