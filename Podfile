platform :ios, '13.0'
inhibit_all_warnings!

target 'maki-maki-ios' do
  use_frameworks!

  # Pods for maki-maki-ios
  pod 'SnapKit', '5.6.0'
  pod 'FirebaseCore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
  pod 'SwiftLint', '0.52.2'
  pod 'InputMask', '6.1.0'
  pod 'IQKeyboardManager', '6.5.0'
  pod 'SkyFloatingLabelTextField', '3.8.0'
  pod 'CHIOTPField', '0.1.0'
  pod 'Moya', '15.0'
  pod 'SnackBar.swift', '0.1.0'
  pod 'SkeletonView', '1.30.4'
  pod 'Kingfisher', '7.7.0'
  pod 'ProgressHUD', '13.6.2'
  pod 'CardIO', '5.4.1'

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
