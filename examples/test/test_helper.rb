require 'minitest/autorun'
require 'YAML'

CONFIG_DIR = './config'.freeze
USERS_YAML_FILE = "#{CONFIG_DIR}/users.yaml".freeze
TAGS_YAML_FILE = "#{CONFIG_DIR}/tags.yaml".freeze
TEAMS_YAML_FILE = "#{CONFIG_DIR}/teams.yaml".freeze
EP_YAML_FILE = "#{CONFIG_DIR}/escalation_policies.yaml".freeze
SCHEDULES_YAML_FILE = "#{CONFIG_DIR}/schedules.yaml".freeze
