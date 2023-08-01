require './test/test_helper'

describe 'when I look at each tag in tags.yaml' do
  before do
    @valid_attribute_names = {
      'label' => String
    }
    @required_attributes = ['label']
  end

  YAML.load_file(TAGS_YAML_FILE)['tags'].each do |name, details|
    it "#{name} must only contain alphanumerics, space, hyphen and underscore characters" do
      assert name =~ /^[a-zA-Z0-9_\- ]+$/, "Tag name '#{name}' contains invalid characters"
    end

    it 'must not include any invalid attributes' do
      details.each do |key, value|
        refute_nil @valid_attribute_names[key], "#{name} has invalid attribute #{key}"
        assert value.is_a?(@valid_attribute_names[key]),
               "#{name} attribute #{key} should be a #{@valid_attribute_names[key]} but is a #{value.class}"
      end
    end

    it 'must have have all required attributes' do
      @required_attributes.each do |attrib|
        assert details[attrib], "#{name} is missing the '#{attrib}' attribute"
      end
    end

    it 'must have a label that does not include whitespace characters' do
      refute details['label'] =~ /\s/, "Tag name '#{name}' label must not contain whitespace"
    end
  end
end
