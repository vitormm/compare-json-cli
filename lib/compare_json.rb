require 'jaro_winkler'
require 'json'

class CompareJson

    def initialize()
        @json_path_1 = nil
        @json_path_2 = nil
        @json_1 = nil
        @json_2 = nil
    end

    def is_valid_json?(file)
        if file.nil? 
            return false
        end    
        JSON.parse(file)
        return true
      rescue JSON::ParserError => e
        return false
    end

    def is_a_valid_file_path?(file_path)
        File.file?(file_path) ? true : false
    end
    
    def generate_input_path_messages(file_path)
        if !is_a_valid_file_path?(file_path)
            "'#{file_path}' is not a valid file or does not exist"
        end     
    end

    def generate_json_validation_messages(file, complete_path)
        if !is_valid_json?(file)
            "'#{complete_path}' is not a valid JSON"
        end
    end

    def load_paths
        @json_path_1 = ARGV[0]
        @json_path_2 = ARGV[1]
    end

    def load_files
        @json_1 = is_a_valid_file_path?(@json_path_1)? File.read(@json_path_1) : nil
        @json_2 = is_a_valid_file_path?(@json_path_2)? File.read(@json_path_2) : nil
    end

    def validate_paths(json_path_1, json_path_2)
        validation_path_messages = []
        validate_json_path_1_message = generate_input_path_messages json_path_1
        validate_json_path_2_message = generate_input_path_messages json_path_2
        validate_json_path_1_message.nil? ? nil : validation_path_messages << validate_json_path_1_message
        validate_json_path_2_message.nil? ? nil : validation_path_messages << validate_json_path_2_message
        validation_path_messages
    end

    def validate_jsons(json_1, json_path_1, json_2, json_path_2)
        validation_json_messages = []
        validate_json_1_message = generate_json_validation_messages json_1, json_path_1
        validate_json_2_message = generate_json_validation_messages json_2, json_path_2
        validate_json_1_message.nil? ? nil : validation_json_messages << validate_json_1_message
        validate_json_2_message.nil? ? nil : validation_json_messages << validate_json_2_message
        validation_json_messages
    end


    def validate
        messages = ""
        load_paths
        validation_path_messages = validate_paths @json_path_1, @json_path_2
        if validation_path_messages.length > 0
            messages += "Please fix the file paths argument. See details below:\n#{validation_path_messages.join("\n")}\n"
            return messages
        end
            
        load_files
        validation_json_messages = validate_jsons @json_1, @json_path_1, @json_2, @json_path_2
        if validation_json_messages.length > 0
            messages += "Some of the json files are not a valid JSON. See details below:\n#{validation_json_messages.join("\n")}"
            return messages
        end
        messages
    end

    def calculate_distance
        jw_distance = JaroWinkler.distance @json_1, @json_2
        jw_distance
    end
    
end