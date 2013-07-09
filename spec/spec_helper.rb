require 'rspec'
require 'active_record'
require 'active_support'
require 'auditing/postgres'

ActiveRecord::Base.establish_connection("postgres://postgres@localhost/auditing")

def clean_sheet
  Auditing::Postgres::Modification.destroy_all
  Auditing::Postgres::Request.destroy_all
end
