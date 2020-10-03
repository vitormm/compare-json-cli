require_relative '../lib/compare_json'



describe CompareJson do

    
    let(:compare_json) {CompareJson.new}

    let(:tmp_json_file) do 
        data = {:name => 'test', :description => 'test'}.to_json
        allow(File).to receive(:read).and_return(data)
        File.read('/tmp/mock_file')
    end

    let(:tmp_json_file_2) do 
        data = {:name => 'test', :foo => 'test'}.to_json
        allow(File).to receive(:read).and_return(data)
        File.read('/tmp/mock_file')
    end

    let(:tmp_not_json_file) do 
        data = "Simple text on file"
        allow(File).to receive(:read).and_return(data)
        File.read('/tmp/mock_file')
    end

    it "validates if the file is a vaid json" do
        expect(compare_json.is_valid_json?(tmp_json_file)).to eq(true) 
        expect(compare_json.is_valid_json?(tmp_not_json_file)).to eq(false) 
    end

    it "validates if a file path is valid" do
        expect(compare_json.is_a_valid_file_path?('./data/BreweriesMaster.json')).to eq(true) 
        expect(compare_json.is_a_valid_file_path?('/tmp')).to eq(false) 
    end

    it "returns a message if the path is not valid" do
        expect(compare_json.generate_input_path_messages('./data/BreweriesMaster.json')).to eq(nil) 
        expect(compare_json.generate_input_path_messages('/tmp/bla')).to include('is not a valid file or does not exist') 
    end

    it "returns a message if the file is not a json" do
        expect(compare_json.generate_json_validation_messages(tmp_json_file, './data/BreweriesMaster.json')).to eq(nil) 
        expect(compare_json.generate_json_validation_messages(tmp_not_json_file,'/tmp/bla')).to include('is not a valid JSON') 
    end

    it "returns an array of messages if any path is not valid" do
        expect(compare_json.validate_paths('./data', '/etc').length).to be(2)
    end

    it "returns an array of messages if any json is not valid" do
        expect(compare_json.validate_jsons(nil, nil, nil, nil).length).to be(2)
    end

    it "returns the jaro winkler distance from zero to one " do
        compare_json.instance_variable_set(:@json_1, tmp_json_file)
        compare_json.instance_variable_set(:@json_2, tmp_json_file_2)
        expect(compare_json.calculate_distance).to be >=0 
        expect(compare_json.calculate_distance).to be <=1 
    end

  end

