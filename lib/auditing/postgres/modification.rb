require 'active_record'
require 'activerecord-postgres-hstore'

module Auditing
  module Postgres
    class Modification < ActiveRecord::Base
      serialize :object_changes, ActiveRecord::Coders::Hstore
      belongs_to :request

      def timestamp
        write_attribute(:timestamp, DateTime.now) if read_attribute(:timestamp).nil?
        read_attribute(:timestamp)
      end

      def self.find_by_request(id)
        find_by_request_id(id)
      end

      def self.find_by_request_id(id)
        find_all_by_request_id(id)
      end

      def self.find_by_day(day)
        where("at >= ? AND at < ?", day.beginning_of_day, day.end_of_day)
      end

      def self.find_by_object_type(object_type)
        find_all_by_object_type(object_type)
      end

      def self.find_by_object_id(object_id)
        find_all_by_object_id(object_id)
      end

      def self.find_by_action(action)
        find_all_by_action(action)
      end
    end
  end
end
