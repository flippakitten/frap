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
        empty_directory("#{lib_directory}/src/animations")
        empty_directory("#{lib_directory}/src/blocs")
        empty_directory("#{lib_directory}/src/models")
        empty_directory("#{lib_directory}/src/resources")
        empty_directory("#{lib_directory}/src/config")
        empty_directory("#{lib_directory}/src/constants")
        empty_directory("#{lib_directory}/src/screens")
        empty_directory("#{lib_directory}/src/widgets")
        invoke :create_files
      end

      def create_files
        template('main.dart.erb', "#{lib_directory}/main.dart")
        template('src/constants/app_constants.dart.erb', "#{src_directory}/constants/app_constants.dart")
        template('src/resources/repository.dart.erb', "#{src_directory}/resources/repository.dart")
        template('src/app.dart.erb', "#{src_directory}/app.dart")
        template('src/animations/slide_right_route.dart.erb', "#{src_directory}/animations/slide_right_route.dart")
        template('src/config/router.dart.erb', "#{src_directory}/config/router.dart")
        template('src/constants/pages_list.dart.erb', "#{src_directory}/constants/pages_list.dart")
        template('src/constants/routing.dart.erb', "#{src_directory}/constants/routing.dart")
        template('src/screens/base.dart.erb', "#{src_directory}/screens/home_screen.dart")
        template('src/screens/undefined_route_screen.dart.erb', "#{src_directory}/screens/undefined_route_screen.dart")
        template('src/widgets/base_app_bar.dart.erb', "#{src_directory}/widgets/base_app_bar.dart")
        template('src/widgets/popup_menu_widget.dart.erb', "#{src_directory}/widgets/popup_menu_widget.dart")

        invoke :setup_pages
      end

      def setup_pages
        inject_into_file("#{src_directory}/config/router.dart", home_router, after: /^.*switch \(settings.name\) \{$/)
        inject_into_file("#{src_directory}/constants/pages_list.dart", home_route, after: /const List<Page> pages = const <Page>\[.*$/)
        append_to_file("#{src_directory}/constants/routing.dart", "const String HomeScreenRoute = '/';\n")
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
        <<~EOF.chomp
          \n  dio: ^2.1.13
            rxdart: ^0.22.0
            bloc_pattern: ^2.2.3
            http: ^0.12.0+2
        EOF
      end

      def home_router
        <<~EOF.chomp
          \n    case HomeScreenRoute:
                return SlideRightRoute(widget:HomeScreen());
        EOF
      end

      def home_route
        <<~EOF.chomp
          \n  const Page(title: 'Home', icon: Icons.home, route: HomeScreenRoute),
        EOF
      end
    end
  end
end
