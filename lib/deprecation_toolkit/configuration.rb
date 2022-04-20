# frozen_string_literal: true

require "active_support/configurable"

module DeprecationToolkit
  class Configuration
    include ActiveSupport::Configurable

    config_accessor(:allowed_deprecations) { [] }
    config_accessor(:attach_to) { [:rails] }
    config_accessor(:behavior) { Behaviors::Raise }
    config_accessor(:deprecation_path) { "test/deprecations" }
    config_accessor(:test_runner) { :minitest }
    config_accessor(:warnings_treated_as_deprecation) { [] }

    configure do
      self.allowed_deprecations = []
      self.attach_to = [:rails]
      self.behavior = Behaviors::Raise
      self.deprecation_path = "test/deprecations"
      self.test_runner = :minitest
      self.warnings_treated_as_deprecation = []
    end
  end
end
