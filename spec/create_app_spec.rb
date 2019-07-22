RSpec.describe Frap::CreateApp do
  context 'new' do
    let(:app_name) { 'test_app' }

    before(:each) do
      FileUtils.rm_rf('test_app')

      expect(Kernel).to receive(:system).with("rails new #{app_name}_server --api -T").and_return(true)
      expect(Dir).to receive(:chdir).with("#{Dir.pwd}/#{app_name}").exactly(3).times
      expect(Kernel).to receive(:system).with("flutter create #{app_name}_ui").and_return(true)
      expect(Dir).to receive(:chdir).with("#{Dir.pwd}/#{app_name}/#{app_name}_ui")
      expect(Kernel).to receive(:system).with('rm -rf lib/').and_return(true)
      expect(Kernel).to receive(:system).with('mkdir lib').and_return(true)
      expect(Kernel).to receive(:system).with('slidy start').and_return(true)
    end

    after(:all) { FileUtils.rm_rf('test_app') }

    subject { Frap::CreateApp.new(app_name) }

    let(:output) { capture(:stdout) { subject.build } }

    it 'Outputs to the terminal' do
      expect(output).to include("Create Parent Directory #{app_name}")
      expect(output).to include("Rails new #{app_name}_server --api")
      expect(output).to include("Flutter create app #{app_name}_ui")
      expect(output).to include("Setup BLoC pattern using Slidy")
    end
  end
end
