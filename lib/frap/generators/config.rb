require 'thor'
require 'thor/group'

module Frap
  module Generators
    class Config < Thor::Group
      include Thor::Actions

      desc 'Generate a config file'
      argument :name
      class_option :test_framework, :default => :test_unit

      def self.source_root
        File.dirname(__FILE__) + '/templates'
      end

      def create_output_directory
        empty_directory(name)
      end

      def create_config_file
        template('config.erb', 'config.yml')
      end
      #
      # def create_git_files
      #   copy_file 'gitignore', '.gitignore'
      #   create_file 'images/.gitkeep'
      #   create_file 'text/.gitkeep'
      # end
      #

    end
  end
end
