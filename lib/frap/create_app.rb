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
      puts "1 ================ Create Parent Directory #{name}"

      gen = Frap::Generators::Config.new([name])
      gen.destination_root = working_dir
      gen.invoke_all
    end

    def create_rails_api_server
      puts "2 ================ Rails new #{name}_server --api"
      Dir.chdir(working_dir)

      system("rails new #{name}_server --api -T")
    end

    def create_flutter_app
      puts "3 ================ Flutter create app #{name}_ui"
      Dir.chdir(working_dir)
      system("flutter create #{name}_ui")
    end

    def setup_bloc_pattern
      puts '4 ================ Setup BLoC pattern using Slidy'
      Dir.chdir("#{working_dir}/#{name}_ui")
      system('rm -rf lib/')
      system('mkdir lib')
      system('slidy start')
      Dir.chdir(working_dir)
    end

    def show_completed_notes
      puts '================================='
      puts 'TODO: Install your favourite Rails Testing library'
    end

    def working_dir
      @working_dir ||= "#{Dir.pwd}/#{name}"
    end
  end
end