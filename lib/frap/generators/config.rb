module Frap
  module Generators
    class Config < Thor::Group
      include Thor::Actions

      desc 'Generate a config file'
      argument :name

      def self.source_root
        File.dirname(__FILE__) + '/templates'
      end

      def configure_directories
        invoke :create_app_dir
      end

      def create_app_dir
        empty_directory(name)
        invoke :create_config_file
      end

      def create_config_file
        template('config.erb', "#{name}/config.yml")
      end
    end
  end
end
