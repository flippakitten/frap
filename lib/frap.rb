require 'frap/version'
require 'frap/create_app'
require 'frap/create_resource'
require 'frap/commands/generate'
require 'frap/generators/config'
require 'frap/generators/flutter_config'
require 'thor'
require 'yaml'

module Frap
  class CLI < Thor
    desc 'version', 'Display MyGem version'
    map %w[-v --version] => :version
    class_option 'verbose', type: :boolean, default: false

    def version
      say "Frap #{Frap::VERSION}"
    end

    desc 'new APP_NAME', 'Lower cased underscored app name'
    long_desc <<-LONGDESC
      Using the "app_name", it will create the parent directory and the Rails and Flutter sub directories, 
      "app_name_server" and "app_name_ui"
    LONGDESC
    def new(app_name)
      CreateApp.new(app_name).build
    end

    desc 'generate GENERATOR RESOURCE_NAME', 'Specify the generator and a name'
    long_desc <<-LONGDESC
      Generate all the boiler plate code such as controllers, pages and blocks for Rails and Flutter.
      run `frap g help` to see a list of existing generators
    LONGDESC
    subcommand 'generate', Frap::Commands::Generate
  end
end
