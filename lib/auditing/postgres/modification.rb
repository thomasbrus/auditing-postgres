require 'active_record'
require 'json'

module Auditing
  module Postgres
    class Modification < ActiveRecord::Base
      belongs_to :request

      def object_changes=(object_changes)
        write_attribute(:object_changes, JSON.dump(object_changes))
      end

      def object_changes
        JSON.load(read_attribute(:object_changes))
      end

      def self.find_by_request(id)
        find_by_request_id(id)
      end

      def self.find_by_request_id(id)
        find_all_by_request_id(id)
      end

      def self.find_by_day(day)
        where("performed_at >= ? AND performed_at < ?", day.beginning_of_day, day.end_of_day)
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
