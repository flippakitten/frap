require 'thor'
require 'thor/group'

module Frap
  module Generators
    class Config < Thor::Group
      include Thor::Actions

      desc 'Generate a config file'
      argument :name

      def self.source_root
        File.dirname(__FILE__) + '/templates'
      end

      def create_config_file
        template('config.erb', 'config.yml')
      end
    end
  end
end
