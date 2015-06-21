Gem::Specification.new do |s|
  s.name        = 'gradleman'
  s.version     = '1.0.0'
  s.license     = 'MIT'
  s.date        = '2015-06-21'
  s.summary     = %q{A man who helps you with gradle stuff.}
  s.description = %q{Command line tool to help you when playing with Gradle.}
  s.authors     = ['Jing Li']
  s.email       = ['thyrlian@gmail.com']
  s.homepage    = 'https://github.com/thyrlian/gradleman'
  s.files       = `git ls-files`.split("\n")
  s.executables = ['gradleman']
end