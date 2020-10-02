require 'optparse'
require 'jaro_winkler'

# Receives two arguments indicating the path of the json files to compare
# opens the files, compare and return the similarity

class CompareJson

    @json_path_1 = nil
    @json_path_2 = nil

    def check_input
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

        @json_path_1 = ARGV[0]
        @json_path_2 = ARGV[1]
    end

    def validate_input_file_paths(file_path)
        if !File.file?(file_path)
            puts "'#{file_path}' is not a valid file or does not exist"
            exit(-1)
        end     
    end

    def validate
        validate_input_file_paths @json_path_1
        validate_input_file_paths @json_path_2
    end

    def calculate_distance
        json_1 = File.read(@json_path_1)
        json_2 = File.read(@json_path_2)
                
        jw_distance = JaroWinkler.distance json_1, json_2
        
        p jw_distance
    end
    
end

app = CompareJson.new
app.check_input
app.validate
app.calculate_distance
