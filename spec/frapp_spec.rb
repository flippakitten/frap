RSpec.describe Frap do
  it 'has a version number' do
    expect(Frap::VERSION).not_to be nil
  end

  it 'can initialize CreateApp' do
    expect(Frap::CreateApp.new('test_app')).not_to be nil
  end
end
