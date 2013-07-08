require 'active_record'
require 'activerecord-postgres-hstore'

module Auditing
  module Postgres
    class Request < ActiveRecord::Base
      serialize :url_parts, ActiveRecord::Coders::Hstore
      serialize :params, ActiveRecord::Coders::Hstore

      # def url=(url)
      # end

      # def modifications
      # end

      # def url_parts=(parts)
      # end

      # def params=(params)
      # end

      # def self.find_by_url(url, partial = false)
      # end

      # def self.find_by_url_parts(params = {}, options = {})
      # end

      # private
      # def self.collection_name
      # end

      # def self.params_to_query_params(hash)
      # end

      # def url_to_parts(url)
      # end
    end
  end
end
