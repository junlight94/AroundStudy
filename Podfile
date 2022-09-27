# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

target 'AroundStudy' do
  use_frameworks! :linkage => :static
  pod 'RealmSwift'
  pod 'SnapKit'
  pod 'FSCalendar'
  pod 'Kingfisher'
  pod 'Mantis'
  pod 'Alamofire'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
