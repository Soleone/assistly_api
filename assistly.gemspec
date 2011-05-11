Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'assistly_api'
  s.version      = '0.1'
  s.summary      = 'Assistly API Ruby bindings using OAuth.'
  s.description  = 'A simple ruby interface to Assistly.'

  s.author = 'Dennis Theisen'
  s.email = 'soleone@gmail.com'
  s.homepage = 'https://github.com/Soleone/assistly_api'
  
  s.files = Dir['lib/**/*']
  s.require_path = 'lib'
  
end