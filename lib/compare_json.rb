require 'jaro_winkler'
require 'json'

class CompareJson

    @json_path_1 = nil
    @json_path_2 = nil
    @json_1 = nil
    @json_2 = nil

    def is_valid_json?(file)
        JSON.parse(file)
        return true
      rescue JSON::ParserError => e
        return false
    end

    def is_a_valid_file_path?(file_path)
        File.file?(file_path) ? true : false
    end
    
    def validate_input_file_paths(file_path)
        if !is_a_valid_file_path?(file_path)
            puts "'#{file_path}' is not a valid file or does not exist"
            exit(-1)
        end     
    end

    def validate_json(file, complete_path)
        if !is_valid_json?(file)
            puts "'#{complete_path}' is not a valid JSON"
            exit(-1)
        end
    end

    def load_paths
        @json_path_1 = ARGV[0]
        @json_path_2 = ARGV[1]
    end

    def load_files
        @json_1 = File.read(@json_path_1)
        @json_2 = File.read(@json_path_2)
    end

    #TODO: Acumulate validations and show result once not inside the methods
    def validate
        load_paths
        validate_input_file_paths @json_path_1
        validate_input_file_paths @json_path_2

        load_files
        validate_json @json_1, @json_path_1
        validate_json @json_2, @json_path_2
    end

    def calculate_distance
        jw_distance = JaroWinkler.distance @json_1, @json_2
        p jw_distance
    end
    
end