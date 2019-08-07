require 'active_support/inflector'

module Frap
  module Generators
    class FlutterResource < Thor::Group
      include Thor::Actions

      desc 'Generate Flutter Config files'
      argument :name
      argument :flutter_app_dir
      argument :fields
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
        @name_capitalized_plural = name_capitalize_pluralize
        @name_capitalized_single = name_capitalized_single
        @name_downcased_plural = name_downcase_pluralize
        @lower_name = lower_name
        @field_types = build_fields
        @field_names = fields.keys
        template('src/screens/base_index.dart.erb', "#{screen_path}/#{lower_name}_index_screen.dart")
        template('src/screens/base_bottom_navigation.dart.erb', "#{screen_path}/#{lower_name}_show_screen.dart")
        template('src/blocs/base_block.dart.erb', "#{src_directory}/blocs/#{@name_downcased_plural}_bloc.dart")
        template('src/models/base_model.dart.erb', "#{src_directory}/models/#{@name_downcased_plural}.dart")
        template('src/resources/base_api_provider.dart.erb', "#{src_directory}/resources/#{lower_name}_api_provider.dart")
        invoke :connect_widgets
      end

      def connect_widgets
        inject_into_file("#{src_directory}/config/router.dart", router_packages, after: /^import 'package:flutter\/material.dart';$/)
        inject_into_file("#{src_directory}/config/router.dart", show_screen_router, after: /^.*switch \(settings.name\) \{$/)
        inject_into_file("#{src_directory}/config/router.dart", index_screen_router, after: /^.*switch \(settings.name\) \{$/)
        inject_into_file("#{src_directory}/constants/pages_list.dart", index_screen_route, after: /const List<Page> pages = const <Page>\[.*$/)
        inject_into_file("#{src_directory}/resources/repository.dart", repository_packages, after: /^import 'dart:async';$/)
        inject_into_file("#{src_directory}/resources/repository.dart", repository_body, after: /^class Repository \{$/)
        append_to_file("#{src_directory}/constants/routing.dart", "const String #{name}IndexScreenRoute = '/#{lower_name.pluralize }'; \n")
        append_to_file("#{src_directory}/constants/routing.dart", "const String #{name}ShowScreenRoute = '/#{lower_name.singularize}';\n")
        # Here we will make sure all imports are handled:
        # Import new resource into routes route and constants
        # Index page with bottom floating button for adding
        # build detail screen with bottom navigations
        # Link navigation buttons to Edit and back to list and delete
      end

      private

      def build_fields
        return unless fields

        fields.map do |key, value|
          case value
            when 'text'
            "String #{key}"
            when 'string'
              "String #{key}"
            when 'integer'
              "int #{key}"
            when 'float'
              "double #{key}"
            when 'bigint'
              "BigInt #{key}"
            when 'datetime'
              "DateTime #{key}"
            when 'boolean'
              "bool #{key}"
            else
              "var #{key}"
          end
        end
      end

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
        name.downcase.singularize
      end

      def name_capitalized_single
        name.capitalize.singularize
      end

      def name_capitalize_pluralize
        name.capitalize.pluralize
      end

      def name_downcase_pluralize
        name.downcase.pluralize
      end

      def router_packages
%Q(
import 'package:#{flutter_app_dir}/src/screens/#{lower_name}/#{lower_name}_index_screen.dart';
import 'package:#{flutter_app_dir}/src/screens/#{lower_name}/#{lower_name}_show_screen.dart';)
      end

      def repository_body
  %Q(
  final #{lower_name}ApiProvider = #{name_capitalized_single}ApiProvider();
  Future<#{name_capitalize_pluralize}> fetchAll#{name_capitalize_pluralize}() => #{lower_name}ApiProvider.fetchAll#{name_capitalize_pluralize}();)
      end

      def repository_packages
%Q(
import 'package:#{flutter_app_dir}/src/resources/#{lower_name}_api_provider.dart';
import 'package:#{flutter_app_dir}/src/models/#{name_downcase_pluralize}.dart';)
      end
    end
  end
end
