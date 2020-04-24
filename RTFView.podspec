#
# Be sure to run `pod lib lint RTFView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RTFView'
  s.version          = '0.1.1'
  s.summary          = 'Custom view transforming text with formatting tags into a view tree'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This custom view has three parts. The parser, the builder(s) and the view itself. The Parser
  converts the formatted text into a list of tokens each containing a list of tags and the text
  itself. The builder(s) is a component which converts a list of consecutive tokens, which all have
  the same "main" tag, into a view representing the formatting. They also can be combined. The view
  itself wraps up these two components into a process of clearing the view tree, getting the new
  token list from the parser and passing it to the root builder.
                       DESC

  s.homepage         = 'https://www.envidual.com/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marco Seidel' => 'marco.seidel@envidual.com' }
  s.source           = { :git => 'https://github.com/Envidual-Marco/RTFView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'RTFView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RTFView' => ['RTFView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.swift_versions = '5.3'
  s.dependency 'SnapKit'
end

