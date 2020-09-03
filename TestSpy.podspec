Pod::Spec.new do |s|
  s.name = 'TestSpy'
  s.version = '0.5.0'
  s.license = 'MIT'
  s.summary = 'Swift Framework for Spy Objects'
  s.homepage = 'https://github.com/f-meloni/TestSpy'
  s.authors = { 'Franco Meloni' => 'franco.meloni91@gmail.com' }
  s.source = { :git => 'https://github.com/f-meloni/TestSpy.git', :tag => s.version }
  s.swift_versions = ['4.2', '5.0']
  s.weak_framework = "XCTest"
  s.pod_target_xcconfig = {
    'APPLICATION_EXTENSION_API_ONLY' => 'YES',
    'ENABLE_BITCODE' => 'NO',
    'OTHER_LDFLAGS' => '$(inherited) -weak-lswiftXCTest -Xlinker -no_application_extension',
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"',
  }

  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/TestSpy/**/*.swift'
  s.dependency 'Nimble', '~> 8.0'
end
