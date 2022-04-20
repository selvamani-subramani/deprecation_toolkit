# frozen_string_literal: true

require "active_support/log_subscriber"

module DeprecationToolkit
  class DeprecationSubscriber < ActiveSupport::LogSubscriber
    def self.already_attached?
      @@deprecation_subscriber ||= false
      unless @@deprecation_subscriber
        @@deprecation_subscriber = true
        return false
      end
      @@deprecation_subscriber
    end

    def deprecation(event)
      message = event.payload[:message]

      Collector.collect(message) unless deprecation_allowed?(event.payload)
    end

    private

    def deprecation_allowed?(payload)
      allowed_deprecations, procs = Configuration.allowed_deprecations.partition { |el| el.is_a?(Regexp) }

      allowed_deprecations.any? { |regex| regex =~ payload[:message] } ||
      procs.any? { |proc| proc.call(payload[:message], payload[:callstack]) }
    end
  end
end
