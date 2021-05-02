require 'json'
require 'erb'

class SchedulerBot::Configuration
  class << self
    def load
      JSON.parse(json_configuration, object_class: OpenStruct)
    end

    private

    def json_configuration
      YAML.load(ERB.new(read_config_file).result).to_json
    end

    def read_config_file
      File.new('configuration.yml').read
    end
  end
end
