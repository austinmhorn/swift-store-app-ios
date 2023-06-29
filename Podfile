# Uncomment the next line to define a global platform for your project
  platform :ios, '9.0'

target 'amh.co' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for amh.co
  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'Firebase/DynamicLinks'
  pod 'FirebaseDatabase'
  pod 'Firebase/Auth'
  pod 'FirebaseUI'
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  
  target 'amh.coTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Firebase'
    pod 'Firebase/Analytics'
    pod 'Firebase/DynamicLinks'
    pod 'FirebaseDatabase'
    pod 'Firebase/Auth'
    pod 'FirebaseUI'
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
  end

  target 'amh.coUITests' do
    # Pods for testing
    pod 'Firebase'
    pod 'Firebase/Analytics'
    pod 'Firebase/DynamicLinks'
    pod 'FirebaseDatabase'
    pod 'Firebase/Auth'
    pod 'FirebaseUI'
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end