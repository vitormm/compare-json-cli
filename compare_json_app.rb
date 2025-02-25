require_relative 'lib/compare_json'
require_relative 'lib/validate_input'

# Receives two arguments indicating the path of the json files to compare
# opens the files, compare and return the similarity between 0 and 1

validate = ValidateInput.new
validate.check_input

app = CompareJson.new
validation_messages = app.validate
if validation_messages.length > 0
    puts validation_messages
    exit(-1)
end

puts app.calculate_distance
