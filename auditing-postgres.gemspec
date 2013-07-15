Gem::Specification.new do |s|
  s.name      = 'auditing-postgres'
  s.version   = '0.0.1'
  s.summary   = 'Audit modifications & requests using Postgres'
  s.authors   = ['Thomas Brus', 'Jan-Willem Koelewijn', 'Dirkjan Bussink']
  s.email     = ['thomas.brus@nedap.com', 'janwillem.koelewijn@nedap.com', 'dirkjan.bussink@nedap.com']
  s.homepage  = 'https://github.com/thomasbrus/auditing-postgres'
  s.license   = 'MIT'
  
  s.files       = Dir['lib/auditing/**/*.rb']
  s.test_files  = Dir.glob('spec/auditing/postgres/*_spec.rb')

  s.add_runtime_dependency('activerecord', '~> 3.2.13')
  s.add_runtime_dependency('activerecord-postgresql-adapter', '~> 0.0.1')
  s.add_runtime_dependency('activerecord-postgres-hstore', '~> 0.7.6')
  s.add_development_dependency('rspec', '~> 2.13.0')
  s.add_development_dependency('rake', '~> 10.1.0')
  s.add_development_dependency('json', '1.6.8')
end
