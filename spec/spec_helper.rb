require 'rspec'
require 'active_record'
require 'auditing/postgres'

ActiveRecord::Base.establish_connection("postgres://postgres@localhost/auditing")

def clean_sheet
  # ...
end