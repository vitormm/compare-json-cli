require 'optparse'

class ValidateInput

    def check_input
        options = {}
        OptionParser.new do |opts|
            opts.banner = "\nUsage: ruby compare_json_app.rb json_path_1 json_path_2"
        
            opts.on( '-h', '--help', 'Display this screen' ) do
                puts opts
            end

            if ARGV.empty? or ARGV.length != 2
                puts opts
                exit(-1)
            end
            
        end.parse!

    end

end
