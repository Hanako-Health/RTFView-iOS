Pod::Spec.new do |s|
  s.name             = 'RTFView'
  s.version          = '0.1.6'
  s.summary          = 'Custom view transforming text with formatting tags into a view tree'

  s.description      = <<-DESC
  This custom view has three parts. The parser, the builder(s) and the view itself. The Parser
  converts the formatted text into a list of tokens each containing a list of tags and the text
  itself. The builder(s) is a component which converts a list of consecutive tokens, which all have
  the same "main" tag, into a view representing the formatting. They also can be combined. The view
  itself wraps up these two components into a process of clearing the view tree, getting the new
  token list from the parser and passing it to the root builder.
                       DESC

  s.homepage         = 'https://www.envidual.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marco Seidel' => 'marco.seidel@envidual.com' }
  s.source           = { :git => 'https://github.com/Envidual-Marco/RTFView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'

  s.source_files = 'RTFView/Classes/**/*'
  
  s.frameworks = 'UIKit'
  s.swift_versions = '5.3'
end

