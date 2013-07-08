require 'active_record'
require 'activerecord-postgres-hstore'

module Auditing
  module Postgres
    class Modification < ActiveRecord::Base
      serialize :object_changes, ActiveRecord::Coders::Hstore

      def timestamp
        write_attribute(:timestamp, DateTime.now) if read_attribute(:timestamp).nil?
        read_attribute(:timestamp)
      end

      def request_id=(id)
      end

      def request
      end

      def request=(request)
      end

      def self.find_by_request(id)
      end

      def self.find_by_request_id(id)
      end

      def self.find_by_day(day)
        where("at >= ? AND at < ?", day.beginning_of_day, day.end_of_day)
      end

      def to_hash
      end

      def changes=(changes)
      end

      def self.collection_name
      end
    end
  end
end
