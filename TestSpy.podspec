Pod::Spec.new do |s|
  s.name = 'TestSpy'
  s.version = '0.4.0'
  s.license = 'MIT'
  s.summary = 'Swift Framework for Spy Objects'
  s.homepage = 'https://github.com/f-meloni/TestSpy'
  s.authors = { 'Franco Meloni' => 'franco.meloni91@gmail.com' }
  s.source = { :git => 'https://github.com/f-meloni/TestSpy.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/TestSpy/**/*.swift'
  s.dependency 'Nimble', '~> 8.0'
  s.swift_version = '4.2'
end
