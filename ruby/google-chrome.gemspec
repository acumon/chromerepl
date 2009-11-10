#! ruby

Gem::Specification.new do |spec|
  spec.name = 'google-chrome'
  spec.version = '0.1'
  spec.summary = 'Ruby client of Google Chrome Developer Tools Protocol'
  spec.author = 'KATO Kazuyoshi'
  spec.email = 'kzys@8-p.info'
  spec.homepage = 'http://8-p.info/chrome-repl/'
  spec.add_dependency('json')

  spec.has_rdoc = true

  spec.files = Dir.glob('lib/**/*.rb')
  spec.executables = ['chrome-repl']
end