RSpec.describe Frap::CreateApp do
  let(:app_name) { 'test_app_create_spec' }
  let(:server_directory) { "#{app_name}/#{app_name}_server" }
  let(:ui_directory) { "#{app_name}/#{app_name}_ui" }
  subject { Frap::CreateApp.new(app_name) }
  let(:build_output) { capture(:stdout) { subject.build } }

  context 'new' do
    it 'outputs to the terminal' do
      expect(build_output).to include("Create Parent Directory #{app_name} in")
      expect(build_output).to include("Rails new #{app_name}_server --api")
      expect(build_output).to include("Flutter create app #{app_name}_ui")
      expect(build_output).to include("Setup BLoC pattern")
    end

    context 'main app structure' do
      it 'creates the app directory' do
        expect(Dir).to exist(app_name)
      end

      it 'creates the server directory' do
        expect(Dir).to exist(server_directory)
      end

      it 'creates the ui directory' do
        expect(Dir).to exist(ui_directory)
      end

      it 'creates the frap config file correctly' do
        config_file = "#{app_name}/config.yml"
        expect(File).to exist(config_file)

        config = YAML.load(File.read(config_file))

        expect(config['flutter_app']).to eq("#{app_name}_ui")
        expect(config['rails_app']).to eq("#{app_name}_server")
      end
    end

    describe 'Flutter BLoC pattern setup' do
      let(:ui_lib_directory) { "#{ui_directory}/lib"}
      let(:ui_src_directory) { "#{ui_lib_directory}/src"}

      context 'app skeleton' do
        it 'creates the ui directories' do
          expect(Dir).to exist(ui_src_directory)
          expect(Dir).to exist("#{ui_src_directory}/animations")
          # expect(Dir).to exist("#{ui_src_directory}/blocs")
          # expect(Dir).to exist("#{ui_src_directory}/models")
          expect(Dir).to exist("#{ui_src_directory}/resources")
          expect(Dir).to exist("#{ui_src_directory}/config")
          expect(Dir).to exist("#{ui_src_directory}/constants")
          expect(Dir).to exist("#{ui_src_directory}/screens")
          expect(Dir).to exist("#{ui_src_directory}/widgets")
        end

        it 'creates files from templates' do
          expect(File).to exist("#{ui_lib_directory}/main.dart")
          expect(File).to exist("#{ui_src_directory}/constants/app_constants.dart")
          expect(File).to exist("#{ui_src_directory}/resources/repository.dart")
          expect(File).to exist("#{ui_src_directory}/app.dart")
          expect(File).to exist("#{ui_src_directory}/animations/slide_right_route.dart")
          expect(File).to exist("#{ui_src_directory}/config/router.dart")
          expect(File).to exist("#{ui_src_directory}/constants/pages_list.dart")
          expect(File).to exist("#{ui_src_directory}/constants/routing.dart")
          expect(File).to exist("#{ui_src_directory}/screens/home_screen.dart")
          expect(File).to exist("#{ui_src_directory}/screens/undefined_route_screen.dart")
          expect(File).to exist("#{ui_src_directory}/widgets/base_app_bar.dart")
          expect(File).to exist("#{ui_src_directory}/widgets/popup_menu_widget.dart")
        end
      end

      context 'file contents' do
        let(:fixtures_directory) {"spec/fixtures/flutter/create_app_spec"}

        it 'populates main.dart' do
          created_file = "#{ui_lib_directory}/main.dart"
          expected_file = "#{fixtures_directory}/lib/main.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates app_constants.dart' do
          created_file = "#{ui_lib_directory}/src/constants/app_constants.dart"
          expected_file = "#{fixtures_directory}/lib/src/constants/app_constants.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates repository.dart' do
          created_file = "#{ui_lib_directory}/src/resources/repository.dart"
          expected_file = "#{fixtures_directory}/lib/src/resources/repository.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates app.dart' do
          created_file = "#{ui_lib_directory}/src/app.dart"
          expected_file = "#{fixtures_directory}/lib/src/app.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates slide_right_route.dart' do
          created_file = "#{ui_lib_directory}/src/animations/slide_right_route.dart"
          expected_file = "#{fixtures_directory}/lib/src/animations/slide_right_route.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates router.dart' do
          created_file = "#{ui_lib_directory}/src/config/router.dart"
          expected_file = "#{fixtures_directory}/lib/src/config/router.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates pages_list.dart' do
          created_file = "#{ui_lib_directory}/src/constants/pages_list.dart"
          expected_file = "#{fixtures_directory}/lib/src/constants/pages_list.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates routing.dart' do
          created_file = "#{ui_lib_directory}/src/constants/routing.dart"
          expected_file = "#{fixtures_directory}/lib/src/constants/routing.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates home_screen.dart' do
          created_file = "#{ui_lib_directory}/src/screens/home_screen.dart"
          expected_file = "#{fixtures_directory}/lib/src/screens/home_screen.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates undefined_route_screen.dart' do
          created_file = "#{ui_lib_directory}/src/screens/undefined_route_screen.dart"
          expected_file = "#{fixtures_directory}/lib/src/screens/undefined_route_screen.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates base_app_bar.dart' do
          created_file = "#{ui_lib_directory}/src/widgets/base_app_bar.dart"
          expected_file = "#{fixtures_directory}/lib/src/widgets/base_app_bar.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end

        it 'populates popup_menu_widget.dart' do
          created_file = "#{ui_lib_directory}/src/widgets/popup_menu_widget.dart"
          expected_file = "#{fixtures_directory}/lib/src/widgets/popup_menu_widget.dart"

          expect(FileUtils.compare_file(expected_file, created_file)).to be_truthy
        end
      end
    end
  end
end
