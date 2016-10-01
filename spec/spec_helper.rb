$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Dir["#{File.dirname(__FILE__)}/fixtures/*.rb"].each { |f| require f }

require 'rspec/collection_matchers'
require 'rspec/its'
require 'active_support/all'
require 'march_madness'
require 'byebug'
