require 'yaml'

module Frap
  class CreateResource
    attr_accessor :name, :attributes, :options

    def initialize(name, options)
      @name = name
      @options = options
    end

    def create_resource
      generate_rails_resource if options['rails']
      generate_flutter_resource if options['flutter']
    end

    private

    def generate_rails_resource
      Dir.chdir("#{working_dir}/#{rails_app_dir}")

      system("rails generate resource #{name} #{fields}")

      Dir.chdir("#{working_dir}")
    end

    def generate_flutter_resource
      Frap::Generators::FlutterResource.new(
        [name.capitalize, flutter_app_dir]
      ).invoke(:configure_directories)
    end

    def fields
      @fields ||= build_fields
    end

    def build_fields
      return unless options[:attributes]

      fields_string = ''
      options[:attributes].each { |k, v| fields_string << "#{k}:#{v} " }

      return fields_string
    end

    private

    def working_dir
      @working_dir ||= Dir.pwd
    end

    def config
      @config ||= YAML.load(File.read('config.yml'))
    end

    def flutter_app_dir
      config['flutter_app']
    end

    def rails_app_dir
      config['rails_app']
    end
  end
end