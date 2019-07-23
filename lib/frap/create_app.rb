require 'thor'
require 'frap/generators/config'

module Frap
  class CreateApp
    attr_accessor :name

    def initialize(name)
      @name = name.downcase
    end

    def build
      setup_parent_directory
      create_rails_api_server
      create_flutter_app
      setup_bloc_pattern
      show_completed_notes
    end

    private

    def setup_parent_directory
      shell.say(shell_text("Create Parent Directory #{name}"), :green)

      Frap::Generators::Config.new(
        [name],
        options: {
          destination_root: Dir.pwd
        }
      ).invoke(:configure_directories)

      Dir.chdir(working_dir)
    end

    def create_rails_api_server
      shell.say(shell_text("Rails new #{server_name} --api -T"), :green)

      Kernel.system("rails new #{server_name} --api -T")
    end

    def create_flutter_app
      shell.say(shell_text("Flutter create app #{ui_name}"), :green)

      Kernel.system("flutter create #{ui_name}")
    end

    def setup_bloc_pattern
      shell.say(shell_text('Setup BLoC pattern'), :green)

      Frap::Generators::FlutterConfig.new(
        [name, ui_name],
        options: {
          destination_root: Dir.pwd
        }
      ).invoke(:configure_directories)

      Dir.chdir("#{working_dir}/#{ui_name}")
      system('git init && flutter pub get')
      Dir.chdir(working_dir)
    end

    def show_completed_notes
      shell.say(shell_text('DONE'), :green)
      shell.say('TODO: Install your favourite Rails Testing library', :yellow)
    end

    def server_name
      "#{name}_server"
    end

    def ui_name
      "#{name}_ui"
    end

    def working_dir
      @working_dir ||= "#{Dir.pwd}/#{name}"
    end

    def shell
      @shell ||= Thor::Shell::Color.new
    end

    def shell_text(text)
      "#{spacer} #{text} #{spacer}"
    end

    def spacer
      '================'
    end
  end
end