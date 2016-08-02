ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'shoulda/matchers'
require 'factory_girl_rails'



Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = "random"
  config.color = true
  config.formatter = 'NyanCatFormatter'
  config.include FactoryGirl::Syntax::Methods
  config.extend ControllerMacros, :type => :controller
  config.include(Shoulda::Callback::Matchers::ActiveModel)
  config.include Features::SessionHelpers, type: :feature

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
    mocks.verify_partial_doubles = true
  end

FactoryGirl::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :action_controller
    with.library :active_model


  end
end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
