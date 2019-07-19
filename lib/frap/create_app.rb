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
      # create_rails_api_server
      # create_flutter_app
      # setup_bloc_patter
      # show_completed_notes
    end

    private

    def setup_parent_directory
      puts "1 ================ Create Parent Directory #{name}"

      system("mkdir #{name}")
      Dir.chdir(name)
      Frap::Generators::Config.new([name]).invoke_all
    end

    def create_rails_api_server
      puts "2 ================ Rails new #{name}_server --api"

      system("rails new #{name}_server --api -T")
    end

    def create_flutter_app
      puts "3 ================ Flutter create app #{name}_ui"
      system("flutter create #{name}_ui")
    end

    def setup_bloc_patter
      puts '4 ================ Setup BLoC pattern using Slidy'
      Dir.chdir("#{name}_ui")
      system('rm -rf lib/')
      system('mkdir lib')
      system('slidy start')
      Dir.chdir('../')
    end

    def show_completed_notes
      puts '================================= '
      puts 'TODO: Install your favourite Rails Testing library'
    end
  end
end