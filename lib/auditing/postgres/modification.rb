require 'active_record'
require 'activerecord-postgres-hstore'

module Auditing
  module Postgres
    class Modification < ActiveRecord::Base
      serialize :object_changes, ActiveRecord::Coders::Hstore

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

      def to_hash
      end

      def changes=(changes)
      end

      def self.collection_name
      end
    end
  end
end
