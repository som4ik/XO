ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'factory_girl_rails'

Dir[Rails.root.join("spec/concerns/**.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
module Shoulda
  module Matchers
    RailsShim.class_eval do
      def self.serialized_attributes_for(model)
        if defined?(::ActiveRecord::Type::Serialized)
          # Rails 5+
          model.columns.select do |column|
            model.type_for_attribute(column.name).is_a?(::ActiveRecord::Type::Serialized)
          end.inject({}) do |hash, column|
            hash[column.name.to_s] = model.type_for_attribute(column.name).coder
            hash
          end
        else
          model.serialized_attributes
        end
      end
    end
  end
end
