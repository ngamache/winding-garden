# spec/models/spec_helper.rb

require File.expand_path("../../../config/environment", __FILE__)

require 'factory_girl_rails'
require 'mongoid'

# require all models for the model tests
Dir["/../../app/models/*.rb"].each {|file| require file }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end 
