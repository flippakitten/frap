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
        File.dirname(__FILE__) + '/templates/flutter'
      end

      def configure_directories
        invoke :create_directories
      end

      def create_directories
        empty_directory("#{lib_directory}/screens/#{lower_name}")

        invoke :create_files
      end

      def create_files
        @name_capitalized_plural = name_capitalize_pluralize
        @name_capitalized_single = name_capitalized_single
        @name_downcased_plural = name_downcased_pluralize
        @lower_name = lower_name
        @field_types = build_fields
        @field_names = fields.keys
        template('screens/base/base_index.dart.erb', "#{screen_path}/#{lower_name}_index_screen.dart")
        template('screens/base/base_bottom_navigation.dart.erb', "#{screen_path}/#{lower_name}_show_screen.dart")
        template('bloc/base/base_block.dart.erb', "#{lib_directory}/bloc/#{name_downcased_pluralize}_bloc.dart")
        template('models/base_model.dart.erb', "#{lib_directory}/models/#{name_downcased_pluralize}.dart")
        template('resources/base_api_provider.dart.erb', "#{lib_directory}/resources/#{lower_name}_api_provider.dart")
        invoke :connect_widgets
      end

      def connect_widgets
        inject_into_file("#{lib_directory}/config/router.dart", router_packages, after: /^import 'package:flutter\/material.dart';$/)
        inject_into_file("#{lib_directory}/config/router.dart", show_screen_router, after: /^.*switch \(settings.name\) \{$/)
        inject_into_file("#{lib_directory}/config/router.dart", index_screen_router, after: /^.*switch \(settings.name\) \{$/)
        inject_into_file("#{lib_directory}/constants/pages_list.dart", index_screen_route, after: /const List<Page> pages = const <Page>\[.*$/)
        inject_into_file("#{lib_directory}/resources/repository.dart", repository_packages, after: /^import 'dart:async';$/)
        inject_into_file("#{lib_directory}/resources/repository.dart", repository_body, after: /^class Repository \{$/)
        append_to_file("#{lib_directory}/constants/routing.dart", "const String #{name}IndexScreenRoute = '/#{lower_name.pluralize }'; \n")
        append_to_file("#{lib_directory}/constants/routing.dart", "const String #{name}ShowScreenRoute = '/#{lower_name.singularize}';\n")
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

      def screen_path
        "#{lib_directory}/screens/#{lower_name}"
      end

      def index_screen_router
        <<~EOF.chomp
          \n    case #{name}IndexScreenRoute:
                return SlideRightRoute(widget:#{name}IndexScreen());
        EOF
      end

      def index_screen_route
        <<~EOF.chomp
          \n  const Page(title: '#{name.pluralize}', icon: Icons.home, route: #{name}IndexScreenRoute),
        EOF
      end

      def show_screen_router
        <<~EOF.chomp
          \n    case #{name}ShowScreenRoute:
                return SlideRightRoute(widget:#{name}ShowScreen());
        EOF
      end

      def show_screen_route
        <<~EOF.chomp
          \n     const Page(title: '#{name}', icon: Icons.home, route: #{name}ShowScreenRoute),
        EOF
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

      def name_downcased_pluralize
        name.downcase.pluralize
      end

      def router_packages
        <<~EOF.chomp
          \nimport 'package:#{flutter_app_dir}/screens/#{lower_name}/#{lower_name}_index_screen.dart';
          import 'package:#{flutter_app_dir}/screens/#{lower_name}/#{lower_name}_show_screen.dart';
        EOF
      end

      def repository_body
        <<~EOF
          \n  final #{lower_name}ApiProvider = #{name_capitalized_single}ApiProvider();
            Future<#{name_capitalize_pluralize}> fetchAll#{name_capitalize_pluralize}() => #{lower_name}ApiProvider.fetchAll#{name_capitalize_pluralize}();
        EOF
      end

      def repository_packages
        <<~EOF.chomp
          \nimport 'package:#{flutter_app_dir}/resources/#{lower_name}_api_provider.dart';
          import 'package:#{flutter_app_dir}/models/#{name_downcased_pluralize}.dart';
        EOF
      end
    end
  end
end
