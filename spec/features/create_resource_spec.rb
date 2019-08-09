RSpec.describe Frap::CreateResource do
  let(:app_name) { 'frap_test_suite_app' }
  let(:resource_name) { 'post' }
  let(:server_directory) { "#{app_name}_server" }
  let(:ui_directory) { "#{app_name}_ui" }
  let(:attributes) { { name: 'string'} }
  let(:options) { { 'rails'=> true, 'flutter' => true, attributes: attributes } }
  let(:create_resource) { Frap::CreateResource.new(resource_name, options).create_resource }

  before(:all) do
    system('git clone https://github.com/flippakitten/frap_test_suite_app.git')
    Dir.chdir('frap_test_suite_app')
  end

  after(:all) do
    Dir.chdir('../')
    FileUtils.rm_rf("#{Dir.pwd}/frap_test_suite_app")
  end

  context 'with valid attributes' do
    before(:all) do
      options = { 'rails'=> true, 'flutter' => true, attributes: { name: 'string' } }
      Frap::CreateResource.new('post', options).create_resource
    end

    context 'resource skeleton' do
      it 'creates rails resources' do
        expect(File).to exist("#{server_directory}/app/controllers/posts_controller.rb")
        expect(File).to exist("#{server_directory}/app/models/post.rb")
      end

      it 'creates flutter resources' do
        expect(File).to exist("#{ui_directory}/lib/src/screens/post")
        expect(File).to exist("#{ui_directory}/lib/src/screens/post/post_index_screen.dart")
        expect(File).to exist("#{ui_directory}/lib/src/screens/post/post_show_screen.dart")
        expect(File).to exist("#{ui_directory}/lib/src/blocs/posts_bloc.dart")
        expect(File).to exist("#{ui_directory}/lib/src/models/posts.dart")
        expect(File).to exist("#{ui_directory}/lib/src/resources/post_api_provider.dart")
      end
    end

    context 'file content' do
      let(:ui_src_directory) { "#{ui_directory}/lib/src" }

      context 'with first resource' do
        let(:fixtures_directory) {"../spec/fixtures/flutter/create_resource_spec/with_post_resource"}

        it 'populates /screens/post/post_index_screen.dart' do
          file = "#{ui_src_directory}/screens/post/post_index_screen.dart"
          expected_file = "#{fixtures_directory}/screens/post/post_index_screen.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates /screens/post/post_show_screen.dart' do
          file = "#{ui_src_directory}/screens/post/post_show_screen.dart"
          expected_file = "#{fixtures_directory}/screens/post/post_show_screen.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates /blocs/posts_bloc.dart' do
          file = "#{ui_src_directory}/blocs/posts_bloc.dart"
          expected_file = "#{fixtures_directory}/blocs/posts_bloc.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates /models/posts.dart' do
          file = "#{ui_src_directory}/models/posts.dart"
          expected_file = "#{fixtures_directory}/models/posts.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates /resources/post_api_provider.dart' do
          file = "#{ui_src_directory}/resources/post_api_provider.dart"
          expected_file = "#{fixtures_directory}/resources/post_api_provider.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates router.dart' do
          file = "#{ui_src_directory}/config/router.dart"
          expected_file = "#{fixtures_directory}/config/router.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates pages_list.dart' do
          file = "#{ui_src_directory}/constants/pages_list.dart"
          expected_file = "#{fixtures_directory}/constants/pages_list.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates repository.dart' do
          file = "#{ui_src_directory}/resources/repository.dart"
          expected_file = "#{fixtures_directory}/resources/repository.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates routing.dart' do
          file = "#{ui_src_directory}/constants/routing.dart"
          expected_file = "#{fixtures_directory}/constants/routing.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end
      end

      context 'with additional resource' do
        before(:all) do
          options = { 'rails'=> true, 'flutter' => true, attributes: { name: 'string', age: 'integer' } }
          Frap::CreateResource.new('blog', options).create_resource
        end

        let(:fixtures_directory) {"../spec/fixtures/flutter/create_resource_spec/with_post_and_blog_resource"}


        it 'populates /models/blogs.dart' do
          file = "#{ui_src_directory}/models/blogs.dart"
          expected_file = "#{fixtures_directory}/models/blogs.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates router.dart' do
          file = "#{ui_src_directory}/config/router.dart"
          expected_file = "#{fixtures_directory}/config/router.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates pages_list.dart' do
          file = "#{ui_src_directory}/constants/pages_list.dart"
          expected_file = "#{fixtures_directory}/constants/pages_list.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates repository.dart' do
          file = "#{ui_src_directory}/resources/repository.dart"
          expected_file = "#{fixtures_directory}/resources/repository.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end

        it 'populates routing.dart' do
          file = "#{ui_src_directory}/constants/routing.dart"
          expected_file = "#{fixtures_directory}/constants/routing.dart"

          expect(FileUtils.compare_file(file, expected_file)).to be_truthy
        end
      end
    end
  end
end
