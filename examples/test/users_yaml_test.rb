require './test/test_helper'

describe 'when I look at each user in users.yaml' do
  before do
    @valid_attribute_names = {
      'email' => String,
      'phone_number' => String,
      'sms_number' => String,
      'country_code' => String,
      'base_role' => String,
      'job_title' => String,
      'time_zone' => String,
      'tag_names' => Array
    }
    @required_attributes = %w[base_role email]
  end

  YAML.load_file(USERS_YAML_FILE)['users'].each do |name, details|
    it "#{name} must only contain alphas and space characters" do
      assert name =~ /^[a-zA-Z'\- ]+$/, "User name '#{name}' contains invalid characters"
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
        refute_nil details[attrib], "#{name} is missing the '#{attrib}' attribute"
      end
    end

    it 'must have tag_names that correspond to real tag entries' do
      tags = YAML.load_file(TAGS_YAML_FILE)['tags']
      details['tag_names']&.each do |tag_name|
        assert tags.keys.include?(tag_name), "#{name} tag_name '#{tag_name}' is not in #{TAGS_YAML_FILE}"
      end
    end
  end
end
