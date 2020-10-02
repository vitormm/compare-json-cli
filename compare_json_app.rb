require_relative 'lib/compare_json'
require_relative 'lib/validate_input'

# Receives two arguments indicating the path of the json files to compare
# opens the files, compare and return the similarity
validate = ValidateInput.new
validate.check_input
app = CompareJson.new
app.validate
app.calculate_distance
