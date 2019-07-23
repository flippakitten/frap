
require 'thor'
require 'thor/group'

module Frap
  module Generators
    class FlutterConfig < Thor::Group
      include Thor::Actions

      desc 'Generate Flutter Config files'
      argument :name
      argument :folder_name

      def self.source_root
        File.dirname(__FILE__) + '/templates/dart'
      end

      def configure_directories
        inject_into_file("#{working_directory}/pubspec.yaml", pub_files, after: /^dependencies:.*$/)
        remove_file("#{lib_directory}/main.dart")
        invoke :create_directories
      end

      def create_directories
        empty_directory("#{lib_directory}/src/home")
        invoke :create_files
      end

      def create_files
        template('main.dart.erb', "#{lib_directory}/main.dart")
        template('src/app_bloc.dart.erb', "#{src_directory}/app_bloc.dart")
        template('src/app_module.dart.erb', "#{src_directory}/app_module.dart")
        template('src/app_widget.dart.erb', "#{src_directory}/app_widget.dart")
        template('src/home/home_bloc.dart.erb', "#{src_directory}/home/home_bloc.dart")
        template('src/home/home_module.dart.erb', "#{src_directory}/home/home_module.dart")
        template('src/home/home_page.dart.erb', "#{src_directory}/home/home_page.dart")
      end

      private

      def working_directory
        "#{destination_root}/#{folder_name}"
      end

      def lib_directory
        "#{working_directory}/lib"
      end

      def src_directory
        "#{lib_directory}/src"
      end

      def pub_files
        %Q(
  dio: ^2.1.13
  rxdart: ^0.22.0
  bloc_pattern: ^2.2.3)
      end
    end
  end
end
