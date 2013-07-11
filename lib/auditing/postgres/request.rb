require 'active_record'
require 'activerecord-postgres-hstore'

module Auditing
  module Postgres
    class Request < ActiveRecord::Base
      serialize :params, ActiveRecord::Coders::Hstore
      has_many :modifications

      def self.find_by_day(day)
        where("performed_at >= ? AND performed_at < ?", day.beginning_of_day, day.end_of_day)
      end

      def self.find_by_url(url, partial = false)
        if partial
          where('url LIKE ?', "%#{url}%")
        else
          where('url = ?', url)
        end
      end

      def self.find_by_user(user_id)
        find_by_user_id(user_id)
      end

      def self.find_by_user_id(user_id)
        find_all_by_user_id(user_id)
      end

      def self.find_by_real_user_id(real_user_id)
        find_all_by_real_user_id(real_user_id)
      end

      def self.find_by_method(method)
        find_all_by_method(method)
      end
    end
  end
end
