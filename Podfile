# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Rijlesboeken' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SVProgressHUD'
  pod 'ImageSlideshow'
  #/Alamofire"
  pod 'SDWebImage'
  pod 'IQKeyboardManagerSwift'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
  pod 'Alamofire', '~> 4.9.1'
  
  # Pods for Rijlesboeken

  target 'RijlesboekenTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RijlesboekenUITests' do
    # Pods for testing
end
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
