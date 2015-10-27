ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'

require "minitest/pride"

class ActiveSupport::TestCase
  fixtures :all
end

DatabaseCleaner.strategy = :transaction

class Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  include FactoryGirl::Syntax::Methods
end

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

Minitest::Reporters.use! [ Minitest::Reporters::SpecReporter.new ]
