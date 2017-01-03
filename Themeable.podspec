Pod::Spec.new do |s|

  s.name    = "Themeable"
  s.version = "0.3.0"
  s.summary = "Easy UIKit theming"
  s.author  = { "Ed Wellbrook" => "edwellbrook@gmail.com" }

  s.license  = "MIT"
  s.homepage = "https://github.com/edwellbrook/Themeable"

  s.source       = { :git => "https://github.com/edwellbrook/Themeable.git", :tag => "v#{s.version}" }
  s.source_files = "Sources/*.swift"

  s.ios.deployment_target = "9.0"

  s.requires_arc = true

end
