Gem::Specification.new do |gem|
  gem.name        = 'billit_representers_argentina'
  gem.version     = '0.9.13'
  gem.date        = '2014-07-07'
  gem.summary     = "Representers for the bill-it module of the Poplus project."
  gem.description = "Representers for the bill-it module of the Poplus project. These provide object-like access to remote data, using Resource-Oriented Architectures in Ruby (ROAR)."
  gem.authors     = ["Marcel Augsburger", "Martín Szyszlican"]
  gem.email       = 'contacto@congresointeractivo.org'
  gem.homepage    = 'https://github.com/congresointeractivo/billit_representers_argentina'
  gem.license     = 'GPL-3'

  gem.files       = `git ls-files`.split("\n")

  gem.add_runtime_dependency "roar", "0.11.19"
  gem.add_runtime_dependency "roar-rails", "0.1.0"
  gem.add_runtime_dependency "activemodel"
end
