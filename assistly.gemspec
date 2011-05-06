Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'assistly'
  s.version      = '0.1.0'
  s.summary      = 'Assistly API Ruby bindings using OAuth.'
  s.description  = 'A simple ruby interface to Assistly.'

  s.author = 'Dennis Theisen'
  s.email = 'soleone@gmail.com'
  s.homepage = 'http://github.com/Soleone/assistly'
  
  s.files = Dir['lib/**/*']
  s.require_path = 'lib'
  
end