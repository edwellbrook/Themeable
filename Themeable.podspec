Pod::Spec.new do |s|

  s.name    = 'Themeable'
  s.version = '0.4.0'
  s.summary = 'Easy UIKit theming'
  s.author  = { 'Ed Wellbrook' => 'edwellbrook@gmail.com' }

  s.license  = 'MIT'
  s.homepage = 'https://github.com/edwellbrook/Themeable'

  s.source       = { :git => 'https://github.com/edwellbrook/Themeable.git', :tag => "v#{s.version}" }
  s.source_files = 'Sources/*.swift'
  s.requires_arc = true

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'

end
