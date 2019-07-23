require 'frap/version'
require 'frap/create_app'
require 'frap/generators/generate'
require 'frap/generators/config'
require 'frap/generators/flutter_config'
require 'thor'
require 'yaml'

module Frap
  class CLI < Thor
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
    subcommand 'generate', Frap::Generators::Generate

    desc 'temp NAME', 'does something temporary'
    def temp(name)
      Frap::Generators::Config.new([name]).invoke_all
    end
  end
end
