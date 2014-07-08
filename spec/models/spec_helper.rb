# spec/models/spec_helper.rb

require File.expand_path("../../../config/environment", __FILE__)

require 'factory_girl_rails'
require 'mongoid'
require_relative '../../app/models/garden.rb'
require_relative '../../app/models/branch.rb'
require_relative '../../app/models/leaf.rb'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end 
