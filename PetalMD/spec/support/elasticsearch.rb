RSpec.configure do |config|
  config.before(:suite) do
    Pokemon.import
  end
end
