# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def db_loads
pod 'RealmSwift'
end

def networking_loads
pod 'Alamofire', '~> 4.4'
pod 'Moya'
end

target 'Realm+Alamofire' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  db_loads()
  networking_loads()
  //
  pod 'HandyJSON', '~> 1.7.1'

  target 'DemoTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

end
