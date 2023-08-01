require './test/test_helper'

describe 'when I look at each parent team in teams.yaml' do
  before do
    @valid_attribute_names = {
      'description' => String,
      'managers' => Array,
      'responders' => Array
    }
  end

  YAML.load_file(TEAMS_YAML_FILE)['parent_teams'].each do |name, details|
    it "#{name} must only contain valid characters" do
      assert name =~ /^[a-zA-Z0-9\.\-_:& ]+$/, "team name '#{name}' contains invalid characters"
    end

    it 'must not include any invalid attributes' do
      details.each do |key, value|
        refute_nil @valid_attribute_names[key], "#{name} has invalid attribute #{key}"
        assert value.is_a?(@valid_attribute_names[key]),
               "#{name} attribute #{key} should be a #{@valid_attribute_names[key]} but is a #{value.class}"
      end
    end
  end
end

describe 'when I look at each subteam in teams.yaml' do
  before do
    @valid_attribute_names = {
      'parent' => String,
      'description' => String,
      'managers' => Array,
      'responders' => Array
    }
  end

  YAML.load_file(TEAMS_YAML_FILE)['sub_teams'].each do |name, details|
    it "#{name} must only contain valid characters" do
      assert name =~ /^[a-zA-Z0-9\.\-_:& ]+$/, "team name '#{name}' contains invalid characters"
    end

    it 'must not include any invalid attributes' do
      details.each do |key, value|
        refute_nil @valid_attribute_names[key], "#{name} has invalid attribute #{key}"
        assert value.is_a?(@valid_attribute_names[key]),
               "#{name} attribute #{key} should be a #{@valid_attribute_names[key]} but is a #{value.class}"
      end
    end

    it 'must have a parent attribute' do
      refute_nil details['parent'], "#{name} is missing the 'parent' attribute"
    end

    it 'must have a parent that corresponds to an entry in parent_teams' do
      parents = YAML.load_file(TEAMS_YAML_FILE)['parent_teams']
      assert parents.keys.include?(details['parent']),
             "#{name} parent '#{details['parent']}' is not in parent_teams"
    end
  end
end
