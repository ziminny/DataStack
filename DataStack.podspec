Pod::Spec.new do |s|
  s.name                  = 'DataStack'
  s.version               = '0.0.1'
  s.summary               = 'Managment core data'
  s.swift_version         = '5.0'
  s.description           = <<-DESC "A modular Swift CoreData framework designed for flexibility, speed, and ease" 
  of integration. Built with modern Swift practices and comprehensive feature set.
  DESC
  s.homepage              = 'https://github.com/ziminny/DataStack'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.authors               = { 'Vagner Oliveira' => 'ziminny@gmail.com' }
  s.source                = { :git => 'https://github.com/ziminny/DataStack.git', :tag => s.version.to_s }
  s.ios.deployment_target = '16.0'
  s.osx.deployment_target = '14.0'
  s.source_files          = 'Sources/**/*' 
  s.dependency 'SwiftFake'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift,h,m}'
    test_spec.framework = 'XCTest'
  end

  end