# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'maki-maki-ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for maki-maki-ios

  pod 'SnapKit', '5.6.0'
  pod 'IQKeyboardManager', '6.5.0'
  pod 'InputMask', '6.1.0'
  pod 'Kingfisher', '7.7.0'
  pod 'Moya', '15.0'
  pod 'FirebaseCore', :git =>
  'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
