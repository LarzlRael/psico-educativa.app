Change icons using flutter_launcher_icons

[Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)

```javascript
flutter pub get
flutter pub run flutter_launcher_icons
```

Configuration pubspeck.yaml
```yaml


flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/app_icon.png"
  min_sdk_android: 21 # android min sdk min:16, default 21
  web:
    generate: true
    image_path: "assets/app_icon.png"
    background_color: "#hexcode"
    theme_color: "#hexcode"
  windows:
    generate: true
    image_path: "assets/app_icon.png"
    icon_size: 48 

dev_dependencies:
  change_app_package_name: ^1.3.0
  flutter_launcher_icons: ^0.13.1
```

Change package_name using plugin

[Change App Package Name](https://pub.dev/packages/change_app_package_name)
dev_dependencies: 
  change_app_package_name: ^1.3.0

  ```javascript
flutter pub get
flutter pub run flutter_launcher_icons
dart run change_app_package_name:main com.new.package.name

```
