require 'active_support/inflector'

module Frap
  module Generators
    class FlutterResource < Thor::Group
      include Thor::Actions

      desc 'Generate Flutter Config files'
      argument :name
      argument :flutter_app_dir

      def self.source_root
        File.dirname(__FILE__) + '/templates/dart'
      end

      def configure_directories
        invoke :create_directories
      end

      def create_directories
        empty_directory("#{lib_directory}/src/screens/#{lower_name}")

        invoke :create_files
      end

      def create_files
        template('src/screens/base_index.dart.erb', "#{screen_path}/#{lower_name}_index_screen.dart")
        template('src/screens/base_bottom_navigation.dart.erb', "#{screen_path}/#{lower_name}_show_screen.dart")

        invoke :connect_widgets
      end

      def connect_widgets
        inject_into_file("#{src_directory}/config/router.dart", router_packages, after: /^import 'package:flutter\/material.dart';$/)
        inject_into_file("#{src_directory}/config/router.dart", show_screen_router, after: /^.*switch \(settings.name\) \{$/)
        inject_into_file("#{src_directory}/config/router.dart", index_screen_router, after: /^.*switch \(settings.name\) \{$/)
        inject_into_file("#{src_directory}/constants/pages_list.dart", index_screen_route, after: /const List<Page> pages = const <Page>\[.*$/)
        append_to_file("#{src_directory}/constants/routing.dart", "const String #{name}IndexScreenRoute = '/#{lower_name.pluralize }'; \n")
        append_to_file("#{src_directory}/constants/routing.dart", "const String #{name}ShowScreenRoute = '/#{lower_name.singularize}';\n")
        # Here we will make sure all imports are handled:
        # Import new resource into routes route and constants
        # Index page with bottom floating button for adding
        # build detail screen with bottom navigations
        # Link navigation buttons to Edit and back to list and delete
      end

      private

      def working_directory
        "#{destination_root}/#{flutter_app_dir}"
      end

      def lib_directory
        "#{working_directory}/lib"
      end

      def src_directory
        "#{lib_directory}/src"
      end

      def screen_path
        "#{src_directory}/screens/#{lower_name}"
      end

      def index_screen_router
        %Q(
     case #{name}IndexScreenRoute:
      return SlideRightRoute(widget:#{name}IndexScreen());)
      end

      def index_screen_route
        %Q(
     const Page(title: '#{name.pluralize}', icon: Icons.home, route: #{name}IndexScreenRoute),)
      end

      def show_screen_router
        %Q(
     case #{name}ShowScreenRoute:
      return SlideRightRoute(widget:#{name}ShowScreen());)
      end

      def show_screen_route
        %Q(
     const Page(title: '#{name}', icon: Icons.home, route: #{name}ShowScreenRoute),)
      end

      def lower_name
        name.downcase
      end
      def router_packages
%Q(
import 'package:#{flutter_app_dir}/src/screens/#{lower_name}/#{lower_name}_index_screen.dart';
import 'package:#{flutter_app_dir}/src/screens/#{lower_name}/#{lower_name}_show_screen.dart';)
      end
    end
  end
end
