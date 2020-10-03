require_relative '../lib/compare_json'



describe CompareJson do

    
    let(:compare_json) {CompareJson.new}

    let(:tmp_json_file) do 
        data = {:name => 'test', :description => 'test'}.to_json
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





  end

