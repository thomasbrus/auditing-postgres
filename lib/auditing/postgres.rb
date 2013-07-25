require 'active_support'

require File.join(File.dirname(__FILE__), 'postgres/request')
require File.join(File.dirname(__FILE__), 'postgres/modification')

module Auditing
  module Postgres
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
      ActiveRecord::Base.establish_connection(configuration.db)
    end

    class Configuration
      attr_accessor :db

      def initialize
        @db = {}
      end
    end
  end
end
