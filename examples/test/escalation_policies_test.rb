require './test/test_helper'

describe 'when I look at each escalation policy in escalation_policies.yaml' do
  before do
    @valid_attribute_names = {
      'teams' => Array,
      'description' => String,
      'num_loops' => Numeric,
      'rules' => Array
    }
    @required_attributes = ['rules']
  end

  YAML.load_file(EP_YAML_FILE)['escalation_policies'].each do |name, details|
    it "#{name} must only contain alphas and space characters" do
      assert name =~ /^[a-zA-Z0-9\.\-_:& ]+$/, "escalation policy name '#{name}' contains invalid characters"
    end

    it 'must not include any invalid attributes' do
      details.each do |key, value|
        refute_nil @valid_attribute_names[key], "escalation policy '#{name}' has invalid attribute #{key}"
        assert value.is_a?(@valid_attribute_names[key]),
               "escalation policy '#{name}' attribute #{key} should be a #{@valid_attribute_names[key]} " \
               "but is a #{value.class}"
      end
    end

    details['teams']&.each do |team|
      it 'each team name in teams must corresponds to an entry in teams.yaml' do
        assert [YAML.load_file(TEAMS_YAML_FILE)['parent_teams'].keys,
                YAML.load_file(TEAMS_YAML_FILE)['sub_teams'].keys].flatten.include?(team),
               "escalation policy '#{name}' team '#{team}' is not in #{TEAMS_YAML_FILE}"
      end
    end

    it 'must have a rules attribute' do
      refute_nil details['rules'], "escalation policy '#{name}' is missing the 'rules' attribute"
    end

    details['rules'].each do |rule|
      it 'each rule must have a escalation_delay_in_minutes attribute' do
        refute_nil rule['escalation_delay_in_minutes'],
                   "escalation policy '#{name}' rule is missing the 'escalation_delay_in_minutes' attribute"
      end

      it 'each rule must have a targets list' do
        refute_nil rule['targets'], "#{name} rule has no 'targets'"
      end

      rule['targets'].each do |target|
        it 'each target must have a valid type' do
          refute_nil target['type'], "#{name} target has no 'type'"
          assert_includes %w[user_reference schedule_reference], target['type'],
                          "escalation policy '#{name}' " \
                          "target type must be one of 'user_reference' or 'schedule_reference'"
        end

        if target['type'] == 'schedule_reference'
          it 'each target schedule_reference must refer to a real schedule name' do
            assert YAML.load_file(SCHEDULES_YAML_FILE)['schedules'].keys.include?(target['target_name']),
                   "escalation policy '#{name}' target_name '#{target['target_name']}' is not in #{SCHEDULES_YAML_FILE}"
          end
        else
          it 'each target user_reference must refer to a real user name' do
            assert YAML.load_file(USERS_YAML_FILE)['users'].keys.include?(target['target_name']),
                   "escalation policy '#{name}' target_name '#{target['target_name']}' is not in #{USERS_YAML_FILE}"
          end
        end
      end
    end
  end
end
