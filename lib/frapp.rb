require "frapp/version"

module Frapp
  class Error < StandardError; end

  class CreateApp
    attr_accessor :name

    def initialize(name)
      @name = name.downcase
    end
    def build
      puts "1 ================ Create Parent Directory #{name}"
      system("mkdir #{name}")
      Dir.chdir(name)
      puts "2 ================ Rails new --api #{name}_server"
      system("rails new #{name}_server")
      puts "3 ================ Flutter create app #{name}_ui"
      system("flutter create #{name}_ui")
      puts '4 ================ Setup BLoC pattern using Slidy'
      Dir.chdir("#{name}_ui")
      system('rm -rf lib/')
      system('mkdir lib')
      system('slidy start')
    end
  end
end
