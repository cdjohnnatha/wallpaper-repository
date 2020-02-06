# frozen_string_literal: true

require "simplecov"
require 'shields_badge'

SimpleCov.start 'rails'
SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge
