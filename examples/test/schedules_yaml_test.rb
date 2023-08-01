require './test/test_helper'

describe 'when I look at each schedule in schedules.yaml' do
  before do
    @valid_attribute_names = {
      'time_zone' => String,
      'description' => String,
      'overflow' => 'Boolean',
      'teams' => Array,
      'layers' => Array
    }
    @required_attributes = %w[time_zone layers]
    @layer_valid_attribute_names = {
      'name' => String,
      'start' => String,
      'rotation_virtual_start' => String,
      'rotation_turn_length_seconds' => Numeric,
      'users' => Array,
      'restrictions' => Array
    }
    @layer_required_attributes = %w[name start rotation_virtual_start rotation_turn_length_seconds users]
  end

  YAML.load_file(SCHEDULES_YAML_FILE)['schedules'].each do |name, details|
    it "#{name} must only contain alphas and space characters" do
      assert name =~ /^[a-zA-Z0-9\.\-_:& ]+$/, "schedule name '#{name}' contains invalid characters"
    end

    it 'must not include any invalid attributes' do
      details.each do |key, value|
        refute_nil @valid_attribute_names[key], "schedule '#{name}' has invalid attribute #{key}"
        if @valid_attribute_names[key] == 'Boolean'
          assert [true, false].include?(value),
                 "schedule '#{name}' attribute #{key} should be a #{@valid_attribute_names[key]} " \
                 "but is a #{value.class}"
        else
          assert value.is_a?(@valid_attribute_names[key]),
                 "schedule '#{name}' attribute #{key} should be a #{@valid_attribute_names[key]} " \
                 "but is a #{value.class}"
        end
      end
    end

    it 'must have all required attributes' do
      @required_attributes.each do |attrib|
        refute_nil details[attrib], "#{name} is missing the '#{attrib}' attribute"
      end
    end

    details['teams']&.each do |team|
      it 'each team name in teams must corresponds to an entry in teams.yaml' do
        assert [YAML.load_file(TEAMS_YAML_FILE)['parent_teams'].keys,
                YAML.load_file(TEAMS_YAML_FILE)['sub_teams'].keys].flatten.include?(team),
               "schedule '#{name}' team '#{team}' is not in #{TEAMS_YAML_FILE}"
      end
    end

    details['layers'].each do |layer|
      it 'layer must not include any invalid attributes' do
        layer.each do |key, value|
          refute_nil @layer_valid_attribute_names[key],
                     "schedule '#{name}' layer '#{layer['name']}' has invalid attribute #{key}"
          assert value.is_a?(@layer_valid_attribute_names[key]),
                 "schedule '#{name}' layer '#{layer['name']}' attribute #{key} should be a " \
                 "#{@layer_valid_attribute_names[key]} but is a #{value.class}"
        end
      end

      it 'layer must have all required attributes' do
        @layer_required_attributes.each do |attrib|
          refute_nil layer[attrib], "schedule '#{name}' layer '#{layer['name']}' is missing the '#{attrib}' attribute"
        end
      end

      layer['users'].each do |user|
        it 'each user on the layer must be a real user in users.yaml' do
          assert YAML.load_file(USERS_YAML_FILE)['users'].keys.include?(user),
                 "schedule '#{name}' layer '#{layer['name']}' '#{user}' is not in #{USERS_YAML_FILE}"
        end
      end

      layer['restrictions']&.each do |restriction|
        it 'restriction must have all required attributes' do
          %w[type start_time_of_day duration_seconds].each do |attrib|
            refute_nil restriction[attrib],
                       "schedule '#{name}' layer '#{layer['name']}' restriction is missing the '#{attrib}' attribute"
          end
        end

        it 'restriction type must be either daily_restriction or weekly_restriction' do
          assert_includes %w[daily_restriction weekly_restriction], restriction['type'],
                          "schedule '#{name}' layer '#{layer['name']}' restriction type '#{restriction['type']}' " \
                          'should be either daily_restriction or weekly_restriction'
        end

        if restriction['type'] == 'weekly_restriction'
          it 'restriction must have start_day_of_week attribute if type is weekly_restriction' do
            refute_nil restriction['start_day_of_week'],
                       "schedule '#{name}' layer '#{layer['name']}' restriction must have 'start_day_of_week' " \
                       'when type is weekly_restriction'
          end
        end
      end
    end
  end
end
