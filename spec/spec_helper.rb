require 'rspec'
require 'auditing/postgres'
require 'pg'

Auditing::Postgres.configure do |config|
  config.db = 'postgres://postgres@localhost/pep_auditing'
end

def clean_sheet
  Auditing::Postgres::Modification.destroy_all
  Auditing::Postgres::Request.destroy_all
end
