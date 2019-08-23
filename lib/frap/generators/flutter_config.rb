module Frap
  module Generators
    class FlutterConfig < Thor::Group
      include Thor::Actions

      desc 'Generate Flutter Config files'
      argument :name
      argument :flutter_app_name

      def self.source_root
        File.dirname(__FILE__) + '/templates/flutter'
      end

      def configure_directories
        inject_into_file("#{working_directory}/pubspec.yaml", pub_files, after: /^dependencies:.*$/)
        remove_file("#{lib_directory}/main.dart")
        invoke :create_directories
      end

      def create_directories
        empty_directory("#{lib_directory}/animations")
        empty_directory("#{lib_directory}/bloc")
        empty_directory("#{lib_directory}/config")
        empty_directory("#{lib_directory}/config/constants")
        empty_directory("#{lib_directory}/models")
        empty_directory("#{lib_directory}/repositories")
        empty_directory("#{lib_directory}/screens")
        empty_directory("#{lib_directory}/widgets")

        invoke :create_files
      end

      def create_files
        @name_capitalized_plural = name.capitalize.pluralize
        @name_capitalized_single = name.capitalize.singularize
        @name_downcased_plural   = name.downcase.pluralize
        @name_downcased_single   = name.downcase.singularize

        template('main.dart.erb', "#{lib_directory}/main.dart")
        template('app.dart.erb', "#{lib_directory}/app.dart")
        template('animations/slide_right_route.dart.erb', "#{lib_directory}/animations/slide_right_route.dart")
        template('bloc/bloc.dart.erb', "#{lib_directory}/bloc/bloc.dart")
        template('bloc/simple_bloc_delegate.dart.erb', "#{lib_directory}/bloc/simple_bloc_delegate.dart")
        template('config/constants/app_constants.dart.erb', "#{lib_directory}/config/constants/app_constants.dart")
        template('config/constants/pages_list.dart.erb', "#{lib_directory}/config/constants/pages_list.dart")
        template('config/constants/routing.dart.erb', "#{lib_directory}/config/constants/routing.dart")
        template('config/router.dart.erb', "#{lib_directory}/config/router.dart")
        template('models/models.dart.erb', "#{lib_directory}/models/models.dart")
        template('repositories/repositories.dart.erb', "#{lib_directory}/repositories/repositories.dart")
        template('screens/home_screen.dart.erb', "#{lib_directory}/screens/home_screen.dart")
        template('screens/undefined_route_screen.dart.erb', "#{lib_directory}/screens/undefined_route_screen.dart")
        template('widgets/base_app_bar.dart.erb', "#{lib_directory}/widgets/base_app_bar.dart")
        template('widgets/popup_menu_widget.dart.erb', "#{lib_directory}/widgets/popup_menu_widget.dart")
      end

      private

      def working_directory
        "#{destination_root}/#{flutter_app_name}"
      end

      def lib_directory
        "#{working_directory}/lib"
      end

      def pub_files
        <<~EOF.chomp
          \n  dio: ^2.1.13
            rxdart: ^0.22.0
            http: ^0.12.0+2
            flutter_bloc: ^0.20.1
        EOF
      end
    end
  end
end
