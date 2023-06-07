platform :ios, '13.0'

target 'maki-maki-ios' do
  use_frameworks!

  # Pods for maki-maki-ios
  pod 'SnapKit', '5.6.0'
  pod 'FirebaseCore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
  pod 'SwiftLint', '0.52.2'
  pod 'InputMask', '6.1.0'
  pod 'IQKeyboardManager', '6.5.0'

  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end

end
